import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/CustomHttp/customhttp.dart';
import 'package:travel_app/custom_widget/air_plane.dart';
import 'package:travel_app/custom_widget/hotel_data.dart';
import 'package:travel_app/custom_widget/resturant_data.dart';
import 'package:travel_app/models/hotel_model.dart';
import 'package:travel_app/providers/hotel_provider.dart';
import 'package:travel_app/providers/resturant_provider.dart';
import 'package:travel_app/screens/hotel_detils_pge.dart';
import 'package:travel_app/screens/login_page.dart';
import 'package:travel_app/utils/constance.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  static const String routeName = '/search';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  String Address = "";
  int currentindex = 0;

  late HotelProvider hotelProvider;
  late ResturantProvider resturantProvider;
  List<String> items = [
    "Hotel/Resort",
    "Restaurant",
    "Air Ticket",
  ];
  List<String> img = [
    "images/hotel.png",
    "images/res.png",
    "images/plane.png",
  ];

  List pageviewlist = [HotelData(), ResturantData(), AirPlane()];
  int current = 0;

  List<Marker> _marker = [];
  List<Marker> _list = [];
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(23.42796133580664, 90.085749655962), zoom: 1);

  Set<Marker> markers = {};

  @override
  void didChangeDependencies() {
    hotelProvider = Provider.of<HotelProvider>(context);
    hotelProvider.allHotel();
    resturantProvider = Provider.of<ResturantProvider>(context);
    resturantProvider.allResturant();
    _marker.addAll(_list);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Where do\nyou wanna go?",
                    style: mytextstyle(Colors.white, 25.sp, FontWeight.w800),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 55.h,
                        width: 55.w,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Center(
                          child: Image.asset("images/rain.png"),
                        ),
                      ),
                      Text(
                        "Rainy",
                        style:
                            mytextstyle(Colors.white, 14.sp, FontWeight.w400),
                      )
                    ],
                  )
                ],
              ),
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/2.png"), fit: BoxFit.cover),
              ),
            ),
            Positioned(
                top: 180.h,
                height: 200.h,
                child: Container(
                  width: 414.w,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(40.r)),
                )),
            Positioned(
                top: 158,
                child: Container(
                  width: 414,
                  child: Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      _searchQuery = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      prefixIcon:
                                          Icon(Icons.location_on_outlined),
                                      hintText: "Select Destination",
                                      filled: true,
                                      fillColor: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0.w),
                                child: InkWell(
                                  onTap: () {
                                    FutureBuilder(
                                        future:
                                            resturantProvider.allResturant(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child: SpinKitFadingCircle(
                                                color: Colors.greenAccent,
                                              ),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.data == null) {
                                            return Text(
                                                "snapshot data are null");
                                          }
                                          return ListView.builder(
                                              itemCount: resturantProvider
                                                  .resturantModel!
                                                  .restaurantsWithMenusAndRating!
                                                  .length,
                                              itemBuilder: (context, index) {
                                                var lat1 = resturantProvider
                                                    .resturantModel!
                                                    .restaurantsWithMenusAndRating![
                                                        1]
                                                    .longitude;
                                                var lat2 = resturantProvider
                                                    .resturantModel!
                                                    .restaurantsWithMenusAndRating![
                                                        2]
                                                    .longitude;
                                                var lat3 = resturantProvider
                                                    .resturantModel!
                                                    .restaurantsWithMenusAndRating![
                                                        3]
                                                    .longitude;
                                                var lon1 = resturantProvider
                                                    .resturantModel!
                                                    .restaurantsWithMenusAndRating![
                                                        1]
                                                    .longitude;
                                                var lon2 = resturantProvider
                                                    .resturantModel!
                                                    .restaurantsWithMenusAndRating![
                                                        2]
                                                    .longitude;
                                                var lon3 = resturantProvider
                                                    .resturantModel!
                                                    .restaurantsWithMenusAndRating![
                                                        3]
                                                    .longitude;
                                                _list.add(Marker(
                                                    markerId: MarkerId("1"),
                                                    position: LatLng(
                                                      double.parse(lat1!),
                                                      double.parse(lon1!),
                                                    )));
                                                _list.add(Marker(
                                                    markerId: MarkerId("2"),
                                                    position: LatLng(
                                                      double.parse(lat2!),
                                                      double.parse(lon2!),
                                                    )));
                                                _list.add(Marker(
                                                    markerId: MarkerId("3"),
                                                    position: LatLng(
                                                      double.parse(lat3!),
                                                      double.parse(lon3!),
                                                    )));

                                                return SizedBox();
                                              });
                                        });
                                    _modalBottomSheet();
                                  },
                                  child: Container(
                                    height: 55.h,
                                    width: 65.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        color: Color(0xff08BA64)),
                                    child: Icon(
                                      Icons.map,
                                      size: 30.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      _searchQuery.isNotEmpty
                          ? FutureBuilder(
                              future: resturantProvider.allResturant(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: SpinKitFadingCircle(
                                      color: Colors.greenAccent,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.data == null) {
                                  return Text("snapshot data are null");
                                }
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _searchQuery.isEmpty
                                        ? 0
                                        : resturantProvider
                                            .resturantModel!
                                            .restaurantsWithMenusAndRating!
                                            .length,
                                    itemBuilder: (context, index) {
                                      var data = resturantProvider
                                              .resturantModel!
                                              .restaurantsWithMenusAndRating![
                                          index];

                                      if (data.location!.toLowerCase().contains(
                                          _searchQuery.toLowerCase())) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            height: 150,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: double.infinity,
                                                  width: 100,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "https://ddtravels.safafirm.com/${data.photo}",
                                                    width: double.infinity,
                                                    height: 250,
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            SpinKitFadingCircle(
                                                      color: Colors.greenAccent,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      "images/hote.jpg",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),

                                                  // NetworkImage(
                                                  //     "https://ddtravels.safafirm.com/${data.photo}"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${data.name}",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on,
                                                                size: 14,
                                                              ),
                                                              Text(
                                                                "${data.location}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Color(
                                                                        0xff9C9C9C)),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                          "${data.description}"),
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                color: Color(
                                                                    0xffF4B806),
                                                              ),
                                                              Icon(
                                                                Icons.star,
                                                                color: Color(
                                                                    0xffF4B806),
                                                              ),
                                                              Icon(
                                                                Icons.star,
                                                                color: Color(
                                                                    0xffF4B806),
                                                              ),
                                                              Icon(
                                                                Icons.star,
                                                                color: Color(
                                                                    0xffF4B806),
                                                              ),
                                                              Icon(
                                                                Icons.star,
                                                                color: Color(
                                                                    0xffF4B806),
                                                              ),
                                                            ],
                                                          ),
                                                          Text("Riview")
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              "images/offershap.png"),
                                                          fit: BoxFit.fitHeight,
                                                        ),
                                                      ),
                                                      height: 40,
                                                      width: 40,
                                                      child: Center(
                                                        child: Text(
                                                          "${data.discount}%",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                      return Container();
                                    });
                              })
                          : Container(),
                      _searchQuery.isEmpty
                          ? Container(
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 8.0.w),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.calendar_today_outlined,
                                              color: Colors.grey,
                                            ),
                                            hintText: "Date",
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        height: 55.h,
                                        width: 65.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                            color: Colors.white),
                                        child: Icon(
                                          Icons.search,
                                          size: 30.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        height: 55.h,
                                        width: 65.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                            color: Colors.white),
                                        child: Icon(
                                          Icons.filter_list,
                                          size: 30.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      _searchQuery.isEmpty
                          ? Container(
                              width: 400,
                              margin: EdgeInsets.all(5),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    /// CUSTOM TABBAR
                                    SizedBox(
                                      width: double.infinity,
                                      height: 60,
                                      child: ListView.builder(
                                          itemCount: items.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (ctx, index) {
                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      current = index;
                                                    });
                                                  },
                                                  child: AnimatedContainer(
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    margin:
                                                        const EdgeInsets.all(5),
                                                    width: 150,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          current == index
                                                              ? BorderRadius
                                                                  .circular(15)
                                                              : BorderRadius
                                                                  .circular(10),
                                                      border: current == index
                                                          ? Border.all(
                                                              color:
                                                                  Colors.green,
                                                              width: 2)
                                                          : null,
                                                    ),
                                                    child: Center(
                                                      child: Row(
                                                        children: [
                                                          ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              child: Image
                                                                  .asset(img[
                                                                      index])),
                                                          Text(
                                                            items[index],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: current ==
                                                                        index
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: current == index,
                                                    child: Container(
                                                      width: 5,
                                                      height: 5,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              shape: BoxShape
                                                                  .circle),
                                                    ))
                                              ],
                                            );
                                          }),
                                    ),

                                    Container(
                                      child: pageviewlist[current] == null
                                          ? ""
                                          : pageviewlist[current],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                )),
          ],
        ),
      )),
    );
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  _modalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              height: 700.h,
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Container(
                          height: 500.h,
                          width: double.infinity,
                          child: GoogleMap(
                            myLocationButtonEnabled: true,
                            myLocationEnabled: true,
                            initialCameraPosition: initialCameraPosition,
                            markers: Set<Marker>.of(_marker),
                            zoomControlsEnabled: false,
                            mapType: MapType.normal,
                            onMapCreated: (GoogleMapController controller) {
                              googleMapController = controller;
                            },
                          ),
                        )
                      ]),
                    ),
                  ),
                  Expanded(child: Text(Address)),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 10.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          Position position = await _determinePosition();
                          setState(() {});
                          googleMapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: LatLng(
                                      position.latitude, position.longitude),
                                  zoom: 14)));

                          setState(() {});
                          markers.add(Marker(
                              markerId: const MarkerId('currentLocation'),
                              position: LatLng(
                                  position.latitude, position.longitude)));
                        },
                        child: Text("Use Location"),
                      ),
                    ),
                  )
                ],
              ));
        });
  }
}
