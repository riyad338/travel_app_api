import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/models/resturant_model.dart';
import 'package:travel_app/providers/hotel_provider.dart';
import 'package:travel_app/providers/resturant_provider.dart';
import 'package:travel_app/screens/location_permission.dart';

class AllLocation extends StatefulWidget {
  AllLocation({
    Key? key,
  }) : super(key: key);

  @override
  State<AllLocation> createState() => _AllLocationState();
}

class _AllLocationState extends State<AllLocation> {
  late ResturantProvider resturantProvider;
  late HotelProvider hotelProvider;
  final Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(23.42796133580664, 90.085749655962), zoom: 10);
  List<Marker> _marker = [];
  List<Marker> _list = const [
    Marker(
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId("1"),
        position: LatLng(23.78911562491093, 90.34850546790082)),
    // Marker(
    //     markerId: MarkerId("1"),
    //     position: LatLng(23.8103, 90.4125),
    //     infoWindow: InfoWindow(title: "title")),
    // Marker(
    //     markerId: MarkerId("1"),
    //     position: LatLng(28.7041, 77.1025),
    //     infoWindow: InfoWindow(title: "t", snippet: "testing")),
    // Marker(
    //     markerId: MarkerId("1"),
    //     position: LatLng(30.0000000, 122.000000),
    //     infoWindow: InfoWindow(title: "r")),
  ];
  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  // late GoogleMapController googleMapController;
  // static const CameraPosition initialCameraPosition = CameraPosition(
  //     target: LatLng(23.42796133580664, 90.085749655962), zoom: 10);
  // List<Marker> _marker = [];
  // List<Marker> _list = [

  //   Marker(
  //       icon: BitmapDescriptor.defaultMarker,
  //       markerId: MarkerId("2"),
  //       position: LatLng(23.42796133580503, 90.085749655102)),
  //   Marker(
  //       icon: BitmapDescriptor.defaultMarker,
  //       markerId: MarkerId("3"),
  //       position: LatLng(23.42796133580505, 90.085749655103)),
  // ];
  @override
  void didChangeDependencies() {
    resturantProvider = Provider.of<ResturantProvider>(context);
    resturantProvider.allResturant();
    hotelProvider = Provider.of<HotelProvider>(context);
    hotelProvider.allHotel();
    _marker.addAll(_list);
    setState(() {});
    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   _marker.addAll(_list);
  //   setState(() {});
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 700.h,
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(children: [
                  // Container(
                  //   height: 1.h,
                  //   child: FutureBuilder(
                  //       future: resturantProvider.allResturant(),
                  //       builder: (context, snapshot) {
                  //         if (snapshot.connectionState ==
                  //             ConnectionState.waiting) {
                  //           return Center(
                  //             child: SpinKitFadingCircle(
                  //               color: Colors.greenAccent,
                  //             ),
                  //           );
                  //         } else if (snapshot.hasError) {
                  //           return Center(child: CircularProgressIndicator());
                  //         } else if (snapshot.data == null) {
                  //           return Text("snapshot data are null");
                  //         }
                  //         return ListView.builder(
                  //             itemCount: resturantProvider.resturantModel!
                  //                 .restaurantsWithMenusAndRating!.length,
                  //             itemBuilder: (context, index) {
                  //               // var lat1 = resturantProvider
                  //               //     .resturantModel!
                  //               //     .restaurantsWithMenusAndRating![
                  //               //         1]
                  //               //     .longitude;
                  //               // var lat2 = resturantProvider
                  //               //     .resturantModel!
                  //               //     .restaurantsWithMenusAndRating![
                  //               //         2]
                  //               //     .longitude;
                  //               // var lat3 = resturantProvider
                  //               //     .resturantModel!
                  //               //     .restaurantsWithMenusAndRating![
                  //               //         3]
                  //               //     .longitude;
                  //               // var lon1 = resturantProvider
                  //               //     .resturantModel!
                  //               //     .restaurantsWithMenusAndRating![
                  //               //         1]
                  //               //     .longitude;
                  //               // var lon2 = resturantProvider
                  //               //     .resturantModel!
                  //               //     .restaurantsWithMenusAndRating![
                  //               //         2]
                  //               //     .longitude;
                  //               // var lon3 = resturantProvider
                  //               //     .resturantModel!
                  //               //     .restaurantsWithMenusAndRating![
                  //               //         3]
                  //               //     .longitude;
                  //               // _list.add(Marker(
                  //               //     markerId: MarkerId("1"),
                  //               //     position: LatLng(
                  //               //       double.parse(lat1!),
                  //               //       double.parse(lon1!),
                  //               //     )));
                  //               // _list.add(Marker(
                  //               //     markerId: MarkerId("2"),
                  //               //     position: LatLng(
                  //               //       double.parse(lat2!),
                  //               //       double.parse(lon2!),
                  //               //     )));
                  //               // _list.add(Marker(
                  //               //     markerId: MarkerId("3"),
                  //               //     position: LatLng(
                  //               //       double.parse(lat3!),
                  //               //       double.parse(lon3!),
                  //               //     )));
                  //               _list.add(Marker(
                  //                   markerId: MarkerId("2"),
                  //
                  //                   position: LatLng(
                  //                       double.parse(
                  //                           "${resturantProvider.resturantModel!.restaurantsWithMenusAndRating![index].latitude}"),
                  //                       double.parse(
                  //                           "${resturantProvider.resturantModel!.restaurantsWithMenusAndRating![index].longitude}"))));
                  //               return SizedBox(
                  //                 height: 20,
                  //               );
                  //             });
                  //       }),
                  // ),
                  Container(
                    height: 1.h,
                    child: FutureBuilder(
                        future: hotelProvider.allHotel(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox();
                          } else if (snapshot.hasError) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.data == null) {
                            return Text("snapshot data are null");
                          }
                          return ListView.builder(
                              itemCount:
                                  hotelProvider.hotelModel!.hotelList!.length,
                              itemBuilder: (context, index) {
                                // var lat1 = resturantProvider
                                //     .resturantModel!
                                //     .restaurantsWithMenusAndRating![
                                //         1]
                                //     .longitude;
                                // var lat2 = resturantProvider
                                //     .resturantModel!
                                //     .restaurantsWithMenusAndRating![
                                //         2]
                                //     .longitude;
                                // var lat3 = resturantProvider
                                //     .resturantModel!
                                //     .restaurantsWithMenusAndRating![
                                //         3]
                                //     .longitude;
                                // var lon1 = resturantProvider
                                //     .resturantModel!
                                //     .restaurantsWithMenusAndRating![
                                //         1]
                                //     .longitude;
                                // var lon2 = resturantProvider
                                //     .resturantModel!
                                //     .restaurantsWithMenusAndRating![
                                //         2]
                                //     .longitude;
                                // var lon3 = resturantProvider
                                //     .resturantModel!
                                //     .restaurantsWithMenusAndRating![
                                //         3]
                                //     .longitude;
                                // _list.add(Marker(
                                //     markerId: MarkerId("1"),
                                //     position: LatLng(
                                //       double.parse(lat1!),
                                //       double.parse(lon1!),
                                //     )));
                                // _list.add(Marker(
                                //     markerId: MarkerId("2"),
                                //     position: LatLng(
                                //       double.parse(lat2!),
                                //       double.parse(lon2!),
                                //     )));
                                // _list.add(Marker(
                                //     markerId: MarkerId("3"),
                                //     position: LatLng(
                                //       double.parse(lat3!),
                                //       double.parse(lon3!),
                                //     )));
                                _list.add(Marker(
                                    markerId: MarkerId(
                                        "${hotelProvider.hotelModel!.hotelList![index].name}"),
                                    infoWindow: InfoWindow(
                                        title: hotelProvider.hotelModel!
                                            .hotelList![index].name),
                                    position: LatLng(
                                        double.parse(
                                            "${hotelProvider.hotelModel!.hotelList![index].latitude}"),
                                        double.parse(
                                            "${hotelProvider.hotelModel!.hotelList![index].longitude}"))));
                                return SizedBox(
                                  height: 20,
                                );
                              });
                        }),
                  ),
                  Container(
                    height: 500.h,
                    width: 400,
                    child: GoogleMap(
                        scrollGesturesEnabled: true,
                        buildingsEnabled: true,
                        initialCameraPosition: _kGooglePlex,
                        markers: Set.of(_marker),
                        onMapCreated: (GoogleMapController controller) {
                          setState(() {
                            _controller.complete(controller);
                          });
                        }),
                    // GoogleMap(
                    //   myLocationButtonEnabled: true,
                    //   myLocationEnabled: true,
                    //   initialCameraPosition: initialCameraPosition,
                    //   markers: Set<Marker>.of(_marker),
                    //   zoomControlsEnabled: true,
                    //   mapType: MapType.normal,
                    //   onMapCreated: (GoogleMapController controller) {
                    //     googleMapController = controller;
                    //   },
                    // ),
                  )
                ]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 10.h,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () async {
                    // Position position = await determinePosition();
                    // setState(() {});
                    // googleMapController.animateCamera(
                    //     CameraUpdate.newCameraPosition(CameraPosition(
                    //         target:
                    //             LatLng(position.latitude, position.longitude),
                    //         zoom: 14)));
                    //
                    // setState(() {});
                    // markers.add(Marker(
                    //     markerId: const MarkerId('currentLocation'),
                    //     position:
                    //         LatLng(position.latitude, position.longitude)));
                  },
                  child: Text("Use my Location"),
                ),
              ),
            )
          ],
        ));
  }
}
