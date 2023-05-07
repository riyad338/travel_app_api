import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:travel_app/utils/constance.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/hotel_model.dart';

class ResturantDetailsPage extends StatefulWidget {
  static const String routeName = '/resturant_details';

  ResturantDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ResturantDetailsPage> createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<ResturantDetailsPage> {
  RestaurantsWithMenusAndRating? resturantList;
  ResturantProvider? resturantProvider;
  String? name;
  String? id;
  GoogleMapController? mapController;
  late GoogleMapController googleMapController;

  Set<Marker> markers = {};
  _currentLoction() {
    markers.add(Marker(
      markerId: MarkerId('currentLocation'),
      position: LatLng(double.parse("${resturantList!.latitude}"),
          double.parse("${resturantList!.longitude}")),
    ));
  }

  void didChangeDependencies() {
    resturantProvider = Provider.of<ResturantProvider>(context);
    resturantProvider!.resturantModel!.restaurantsWithMenusAndRating;
    final argList = ModalRoute.of(context)!.settings.arguments as List;

    resturantList = argList[0];
    name = argList[1];
    id = argList[2].toString();

    super.didChangeDependencies();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                child: CachedNetworkImage(
                  imageUrl:
                      "https://ddtravels.safafirm.com/${resturantList!.photo}",
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => SpinKitFadingCircle(
                    color: Colors.greenAccent,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                height: 200.h,
                width: double.infinity,
                color: Colors.grey,
              ),
              Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                    ),
                  )),
              Positioned(
                  top: 10,
                  right: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.white12,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ))),
                      SizedBox(
                        height: 10.h,
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.white12,
                          child: Icon(
                            Icons.photo_library,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                          width: 50,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            "Hotel",
                            style:
                                mytextstyle(Colors.white, 12, FontWeight.w400),
                          ))),
                    ],
                  )),
              Positioned(
                top: 150,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30.r))),
                  height: 680,
                  width: 414.w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color(0xffF4B806),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        "${resturantList!.restaurantrating!.star}"),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    final url = "${resturantList!.youtubeLink}";
                                    launchUrl(Uri.parse(url));
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Image.asset("images/youtube.png"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            "${name}",
                            style: mytextstyle(
                                Color(0xff131B1A), 24, FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Color(0xff9C9C9C),
                              ),
                              Text(
                                "${resturantList!.location}",
                                style: mytextstyle(
                                    Color(0xff9C9C9C), 12, FontWeight.w400),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "${resturantList!..description}...\nRed More..",
                              maxLines: 3,
                              style: mytextstyle(
                                  Color(0xff9C9C9C), 14, FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Divider(
                              color: Colors.grey,
                              height: 3,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      child: Icon(Icons.book),
                                      height: 70,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white),
                                    ),
                                    Text("Menu")
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      child: Icon(Icons.call),
                                      height: 70,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white),
                                    ),
                                    Text("Contct"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      child: Icon(Icons.book),
                                      height: 70,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white),
                                    ),
                                    Text("Order Online")
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: Container(
                              height: 225,
                              width: 380,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      resturantList!.restaurantMenu!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        height: 250,
                                        width: 380,
                                        child: Image.network(
                                          resturantList!.restaurantMenu![index]
                                                      .photo !=
                                                  null
                                              ? "${resturantList!.restaurantMenu![index].photo}"
                                              : "",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor: Color(0xff08BA64)),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Claim 50% Discount"),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Icon(Icons.arrow_forward)
                                ],
                              )),
                          // Container(
                          //   height: 250,
                          //   child: ListView.builder(
                          //       shrinkWrap: true,
                          //       itemCount: resturantList!.restaurantMenu!.length,
                          //       itemBuilder: (context, index) {
                          //         var roomdata = hotelList!.rooms![index];
                          //         return Padding(
                          //           padding:
                          //           const EdgeInsets.symmetric(vertical: 8),
                          //           child: Container(
                          //             height: 150,
                          //             color: Colors.yellow,
                          //             width: double.infinity,
                          //             child: Row(
                          //               children: [
                          //                 Container(
                          //                   height: 150,
                          //                   width: 100.w,
                          //                   color: Colors.red,
                          //
                          //                   // NetworkImage(
                          //                   //     "https://ddtravels.safafirm.com/${data.photo}"),
                          //                 ),
                          //                 Column(
                          //                   children: [
                          //                     Text(
                          //                       "${roomdata.title}",
                          //                       style: mytextstyle(Colors.black,
                          //                           18, FontWeight.w500),
                          //                     ),
                          //                     Text(
                          //                       "${roomdata.description}",
                          //                       style: mytextstyle(Colors.black,
                          //                           18, FontWeight.w500),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         );
                          //       }),
                          // ),
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  "Latest Review",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_forward_rounded))
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.teal,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "name",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffF4B806),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffF4B806),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffF4B806),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffF4B806),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffF4B806),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text("20 Feb, 2023")
                                  ],
                                ),
                                resturantList!.restaurantrating!.feedback ==
                                        null
                                    ? Text("")
                                    : Text(
                                        "${resturantList!.restaurantrating!.feedback}"),
                                Text(
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 300.h,
                                width: 400,
                                child: GoogleMap(
                                  compassEnabled: true,
                                  myLocationButtonEnabled: true,
                                  myLocationEnabled: true,
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          double.parse(
                                              "${resturantList!.latitude}"),
                                          double.parse(
                                              "${resturantList!.longitude}")),
                                      zoom: 14),
                                  markers: markers,
                                  zoomControlsEnabled: true,
                                  mapType: MapType.normal,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    googleMapController = controller;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ),

                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              onTap: () {
                                final url = "${resturantList!.facebookPage}";
                                launchUrl(Uri.parse(url));
                              },
                              tileColor: Colors.white12,
                              leading: Icon(Icons.facebook_rounded),
                              title: Text(
                                "Facebook Page",
                                style: TextStyle(),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              onTap: () {
                                final url = "${resturantList!.websiteLink}";
                                launchUrl(Uri.parse(url));
                              },
                              tileColor: Colors.white12,
                              leading: Icon(Icons.my_library_books_rounded),
                              title: Text(
                                "Visit Website",
                                style: TextStyle(),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              onTap: () {},
                              tileColor: Colors.white12,
                              leading: Icon(Icons.my_library_books_rounded),
                              title: Text(
                                "Privacy Policy",
                                style: TextStyle(),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              tileColor: Colors.white12,
                              leading: Icon(Icons.headset_mic_outlined),
                              title: Text(
                                "How to Claim?",
                                style: TextStyle(),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              tileColor: Colors.white12,
                              leading: Icon(
                                Icons.headset_mic_outlined,
                              ),
                              title: Text(
                                "Help & Support",
                                style: TextStyle(),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
