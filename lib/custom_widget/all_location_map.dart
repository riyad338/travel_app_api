import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/models/hotel_model.dart';
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
  HotelList? ind;
  late HotelProvider hotelProvider;
  final Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(23.42796133580664, 90.085749655962), zoom: 10);
  List<Marker> _marker = [];
  List<Marker> _list = [
    // Marker(
    //     icon: BitmapDescriptor.defaultMarker,
    //     markerId: MarkerId("1"),
    //     position: LatLng(23.78911562491093, 90.34850546790082)),
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
  // void initState() {
  //   hotelProvider = Provider.of<HotelProvider>(context);
  //   super.initState();
  //   hotelProvider.allHotel();
  //   setState(() {});
  // }

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

  newb() {
    resturantProvider = Provider.of<ResturantProvider>(context);
    resturantProvider.allResturant();
    hotelProvider = Provider.of<HotelProvider>(context);
    hotelProvider.allHotel();
    _marker.addAll(_list);
    print("...............................................${_list}");
  }

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
                  Container(
                    height: 1.h,
                    child: FutureBuilder<HotelModel>(
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
                                ind =
                                    hotelProvider.hotelModel!.hotelList![index];
                                _list.add(Marker(
                                    icon: BitmapDescriptor.defaultMarker,
                                    markerId: MarkerId(
                                        "${hotelProvider.hotelModel!.hotelList![0].name}"),
                                    infoWindow: InfoWindow(
                                        title: hotelProvider
                                            .hotelModel!.hotelList![0].name),
                                    position: LatLng(
                                        double.parse(
                                            "${hotelProvider.hotelModel!.hotelList![0].latitude}"),
                                        double.parse(
                                            "${hotelProvider.hotelModel!.hotelList![0].longitude}"))));

                                // print(
                                //     "....................${hotelProvider.hotelModel!.hotelList![0].latitude}");
                                // print(
                                //     "....................${hotelProvider.hotelModel!.hotelList![0].longitude}");
                                return SizedBox();
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
                        markers: Set<Marker>.of([
                          Marker(
                              icon: BitmapDescriptor.defaultMarker,
                              markerId: MarkerId("${ind!.name}"),
                              infoWindow: InfoWindow(title: ind!.name),
                              position: LatLng(double.parse("${ind!.latitude}"),
                                  double.parse("${ind!.longitude}")))
                        ]),
                        onMapCreated: (GoogleMapController controller) {
                          setState(() {
                            _controller.complete(controller);
                          });
                        }),
                  ),
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
