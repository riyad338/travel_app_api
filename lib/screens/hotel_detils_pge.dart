import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/providers/hotel_provider.dart';
import 'package:travel_app/utils/constance.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/hotel_model.dart';

class HotelDetailsPage extends StatefulWidget {
  static const String routeName = '/hotel_detail';

  HotelDetailsPage({Key? key}) : super(key: key);

  @override
  State<HotelDetailsPage> createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  GoogleMapController? mapController;
  late GoogleMapController googleMapController;

  Set<Marker> markers = {};
  HotelList? hotelList;
  String? name;
  String? id;
  HotelProvider? hotelProvider;
  void didChangeDependencies() {
    hotelProvider = Provider.of<HotelProvider>(context);
    hotelProvider!.hotelModel!.hotelList;

    final argList = ModalRoute.of(context)!.settings.arguments as List;

    hotelList = argList[0];
    name = argList[1];
    id = argList[2].toString();

    super.didChangeDependencies();
  }

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
                      "https://ddtravels.safafirm.com/${hotelList!.photo}",
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    height: 680,
                    width: 385.w,
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
                                    Text("${hotelList!.hotelRating!.star}"),
                                  ],
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade200,
                                  child: Image.asset("images/youtube.png"),
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
                                "${hotelList!.location}",
                                style: mytextstyle(
                                    Color(0xff9C9C9C), 12, FontWeight.w400),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "${hotelList!..description}...\nRed More..",
                              maxLines: 3,
                              style: mytextstyle(
                                  Color(0xff9C9C9C), 14, FontWeight.w400),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Available Offers",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month_outlined,
                                          color: Color(0xff9C9C9C)),
                                      Text(
                                        "Change Date",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13.sp,
                                            color: Color(0xff9C9C9C)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text("More",
                                          style: TextStyle(
                                              color: Color(0xff9C9C9C))),
                                      Icon(Icons.arrow_forward_ios,
                                          color: Color(0xff08BA64))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 250,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: hotelList!.rooms!.length,
                                itemBuilder: (context, index) {
                                  var roomdata = hotelList!.rooms![index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Container(
                                      height: 150,
                                      color: Colors.yellow,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 100.w,
                                            color: Colors.red,

                                            // NetworkImage(
                                            //     "https://ddtravels.safafirm.com/${data.photo}"),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "${roomdata.title}",
                                                style: mytextstyle(Colors.black,
                                                    18, FontWeight.w500),
                                              ),
                                              Text(
                                                "${roomdata.description}",
                                                style: mytextstyle(Colors.black,
                                                    18, FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Services",
                                  style: mytextstyle(
                                      Colors.black, 17, FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    Text("${hotelList!.services}",
                                        style: TextStyle(
                                            color: Color(0xff9C9C9C),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      "${hotelList!.services}",
                                      style: TextStyle(
                                          color: Color(0xff9C9C9C),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    Text("${hotelList!.services}",
                                        style: TextStyle(
                                            color: Color(0xff9C9C9C),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    Text("${hotelList!.services}",
                                        style: TextStyle(
                                            color: Color(0xff9C9C9C),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    Text("${hotelList!.services}",
                                        style: TextStyle(
                                            color: Color(0xff9C9C9C),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    Text("${hotelList!.services}",
                                        style: TextStyle(
                                            color: Color(0xff9C9C9C),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    Text("${hotelList!.services}",
                                        style: TextStyle(
                                            color: Color(0xff9C9C9C),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp)),
                                  ],
                                ),
                              ],
                            ),
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
                                  icon: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Color(0xff9C9C9C),
                                  ))
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
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.sp,
                                                  color: Color(0xff000000)),
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
                                    Text("20 Feb, 2023",
                                        style: mytextstyle(Color(0xff9C9C9C),
                                            11, FontWeight.w400))
                                  ],
                                ),
                                Text(
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ",
                                  style: mytextstyle(
                                      Color(0xff9C9C9C), 14, FontWeight.w400),
                                ),
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
                                              "${hotelList!.latitude}"),
                                          double.parse(
                                              "${hotelList!.longitude}")),
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
                            child: ListTile(
                              onTap: () {
                                final url =
                                    'https://www.facebook.com/mh.riyad.526';
                                launchUrl(Uri.parse(url));
                              },
                              tileColor: Colors.white12,
                              leading: Icon(
                                Icons.facebook_rounded,
                                size: 30,
                              ),
                              title: Text(
                                "Facebook Page",
                                style: TextStyle(color: Color(0xff9C9C9C)),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              tileColor: Colors.white12,
                              leading: Image.asset("images/website.png"),
                              title: Text(
                                "Visit Website",
                                style: TextStyle(color: Color(0xff9C9C9C)),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Color(0xff9C9C9C)),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              tileColor: Colors.white12,
                              leading: Image.asset("images/privacypolicy.png",
                                  color: Color(0xff9C9C9C)),
                              title: Text(
                                "Privacy Policy",
                                style: TextStyle(color: Color(0xff9C9C9C)),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Color(0xff9C9C9C)),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              tileColor: Colors.white12,
                              leading: Image.asset("images/claim.png",
                                  color: Color(0xff9C9C9C)),
                              title: Text(
                                "How to Claim?",
                                style: TextStyle(color: Color(0xff9C9C9C)),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Color(0xff9C9C9C)),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              tileColor: Colors.white12,
                              leading: Icon(
                                Icons.headset_mic_outlined,
                                color: Color(0xff9C9C9C),
                              ),
                              title: Text(
                                "Help & Support",
                                style: TextStyle(color: Color(0xff9C9C9C)),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Color(0xff9C9C9C)),
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
// class HotelDetailsPage extends StatefulWidget {
//   static const String routeName = '/hotel_detail';
//
//   HotelDetailsPage({Key? key}) : super(key: key);
//
//   @override
//   State<HotelDetailsPage> createState() => _HotelDetailsPageState();
// }
//
// class _HotelDetailsPageState extends State<HotelDetailsPage> {

//   HotelList? hotelList;
//   String? name;
//   String? id;
//   HotelProvider? hotelProvider;
//   void didChangeDependencies() {
//     hotelProvider = Provider.of<HotelProvider>(context);
//     hotelProvider!.hotelModel!.hotelList;
//
//     final argList = ModalRoute.of(context)!.settings.arguments as List;
//
//     hotelList = argList[0];
//     name = argList[1];
//     id = argList[2].toString();
//     markers;
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           height: double.infinity,
//           width: double.infinity,
//           child: Stack(
//             children: [
//               Container(
//                 child: CachedNetworkImage(
//                   imageUrl:
//                       "https://ddtravels.safafirm.com/${hotelList!.photo}",
//                   width: double.infinity,
//                   height: 200.h,
//                   fit: BoxFit.cover,
//                   placeholder: (context, url) => SpinKitFadingCircle(
//                     color: Colors.greenAccent,
//                   ),
//                   errorWidget: (context, url, error) => Icon(Icons.error),
//                 ),
//                 height: 200.h,
//                 width: double.infinity,
//                 color: Colors.grey,
//               ),
//               Positioned(
//                   top: 10,
//                   left: 10,
//                   child: Container(
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white12,
//                       child: IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.arrow_back_ios,
//                             color: Colors.white,
//                           )),
//                     ),
//                   )),
//               Positioned(
//                   top: 10,
//                   right: 10,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       CircleAvatar(
//                           backgroundColor: Colors.white12,
//                           child: IconButton(
//                               onPressed: () {},
//                               icon: Icon(
//                                 Icons.more_vert,
//                                 color: Colors.white,
//                               ))),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       CircleAvatar(
//                           backgroundColor: Colors.white12,
//                           child: Icon(
//                             Icons.photo_library,
//                             color: Colors.white,
//                           )),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Container(
//                           width: 50,
//                           height: 20,
//                           decoration: BoxDecoration(
//                               color: Colors.white12,
//                               borderRadius: BorderRadius.circular(20)),
//                           child: Center(
//                               child: Text(
//                             "Hotel",
//                             style:
//                                 mytextstyle(Colors.white, 12, FontWeight.w400),
//                           ))),
//                     ],
//                   )),
//               Positioned(
//                 top: 150,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(30),
//                             topLeft: Radius.circular(30))),
//                     height: 680,
//                     width: 385.w,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.star,
//                                       color: Color(0xffF4B806),
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text("${hotelList!.hotelRating!.star}"),
//                                   ],
//                                 ),
//                                 CircleAvatar(
//                                   child: Icon(Icons.youtube_searched_for),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Text(
//                             "${name}",
//                             style: mytextstyle(
//                                 Color(0xff131B1A), 24, FontWeight.w500),
//                           ),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.location_on,
//                                 color: Color(0xff9C9C9C),
//                               ),
//                               Text(
//                                 "${hotelList!.location}",
//                                 style: mytextstyle(
//                                     Color(0xff9C9C9C), 12, FontWeight.w400),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(vertical: 10.0),
//                             child: Text(
//                               "${hotelList!..description}...\nRed More..",
//                               maxLines: 3,
//                               style: mytextstyle(
//                                   Color(0xff9C9C9C), 14, FontWeight.w400),
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Available Offers",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 20.sp,
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(Icons.calendar_month_outlined),
//                                       Text("Change Date")
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Container(
//                                 child: Row(
//                                   children: [
//                                     Text("More"),
//                                     Icon(Icons.arrow_forward_ios)
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                           Container(
//                             height: 250,
//                             decoration: BoxDecoration(),
//                             child: ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: hotelList!.rooms!.length,
//                                 itemBuilder: (context, index) {
//                                   var roomdata = hotelList!.rooms![index];
//                                   return Padding(
//                                     padding:
//                                         const EdgeInsets.symmetric(vertical: 8),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.white70,
//                                           borderRadius:
//                                               BorderRadius.circular(20)),
//                                       height: 150,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Container(
//                                             height: double.infinity,
//                                             width: 100,
//                                             child: CachedNetworkImage(
//                                               imageUrl:
//                                                   "https://ddtravels.safafirm.com/${roomdata.image}",
//                                               width: double.infinity,
//                                               height: 250,
//                                               fit: BoxFit.cover,
//                                               placeholder: (context, url) =>
//                                                   SpinKitFadingCircle(
//                                                 color: Colors.greenAccent,
//                                               ),
//                                               errorWidget:
//                                                   (context, url, error) =>
//                                                       Image.asset(
//                                                 "images/hote.jpg",
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//
//                                             // NetworkImage(
//                                             //     "https://ddtravels.safafirm.com/${data.photo}"),
//                                           ),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     "${roomdata.title}",
//                                                     style:
//                                                         TextStyle(fontSize: 18),
//                                                   ),
//                                                   Text(
//                                                     "${roomdata.description}",
//                                                     style: TextStyle(
//                                                         fontSize: 13,
//                                                         color:
//                                                             Color(0xff9C9C9C)),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Container(
//                                                       height: 20.h,
//                                                       width: 100.w,
//                                                       decoration: BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(15),
//                                                           color: Colors
//                                                               .grey.shade300),
//                                                       child: Center(
//                                                           child: FittedBox(
//                                                         child: Text(
//                                                             "${roomdata.beds}",
//                                                             style: mytextstyle(
//                                                                 Color(
//                                                                     0xff9C9C9C),
//                                                                 13.sp,
//                                                                 FontWeight
//                                                                     .w400)),
//                                                       ))),
//                                                   SizedBox(
//                                                     width: 4.w,
//                                                   ),
//                                                   Container(
//                                                       height: 20.h,
//                                                       width: 80.w,
//                                                       decoration: BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(15),
//                                                           color: Colors
//                                                               .grey.shade300),
//                                                       child: Center(
//                                                           child: Text(
//                                                               "Restaurent",
//                                                               style: mytextstyle(
//                                                                   Color(
//                                                                       0xff9C9C9C),
//                                                                   13.sp,
//                                                                   FontWeight
//                                                                       .w400)))),
//                                                 ],
//                                               ),
//                                               Column(
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Icon(
//                                                         Icons.star,
//                                                         color:
//                                                             Color(0xffF4B806),
//                                                       ),
//                                                       Icon(
//                                                         Icons.star,
//                                                         color:
//                                                             Color(0xffF4B806),
//                                                       ),
//                                                       Icon(
//                                                         Icons.star,
//                                                         color:
//                                                             Color(0xffF4B806),
//                                                       ),
//                                                       Icon(
//                                                         Icons.star,
//                                                         color:
//                                                             Color(0xffF4B806),
//                                                       ),
//                                                       Icon(
//                                                         Icons.star,
//                                                         color:
//                                                             Color(0xffF4B806),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Text("Riview")
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Container(
//                                                 decoration: BoxDecoration(
//                                                   image: DecorationImage(
//                                                     image: AssetImage(
//                                                         "images/offershap.png"),
//                                                     fit: BoxFit.fitHeight,
//                                                   ),
//                                                 ),
//                                                 height: 40,
//                                                 width: 40,
//                                                 child: Center(
//                                                   child: Text(
//                                                     "${roomdata.discount}%",
//                                                     style: TextStyle(
//                                                         fontSize: 13,
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                         color: Colors.white),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Column(
//                                                 children: [
//                                                   Text("available offer"),
//                                                   Text(
//                                                     "${roomdata.discountPrice}\$",
//                                                     style: mytextstyle(
//                                                       Color(0xff08BA64),
//                                                       15.sp,
//                                                       FontWeight.w700,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     "${roomdata.price}\$",
//                                                     style: TextStyle(
//                                                       decoration: TextDecoration
//                                                           .lineThrough,
//                                                       color: Color(0xff08BA64),
//                                                       fontSize: 13.sp,
//                                                       fontWeight:
//                                                           FontWeight.w300,
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Services",
//                                   style: mytextstyle(
//                                       Colors.black, 17, FontWeight.w500),
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.done,
//                                       color: Colors.green,
//                                     ),
//                                     Text("${hotelList!.services}"),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.done,
//                                       color: Colors.green,
//                                     ),
//                                     Text("${hotelList!.services}"),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.done,
//                                       color: Colors.green,
//                                     ),
//                                     Text("${hotelList!.services}"),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.done,
//                                       color: Colors.green,
//                                     ),
//                                     Text("${hotelList!.services}"),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.done,
//                                       color: Colors.green,
//                                     ),
//                                     Text("${hotelList!.services}"),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.done,
//                                       color: Colors.green,
//                                     ),
//                                     Text("${hotelList!.services}"),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.done,
//                                       color: Colors.green,
//                                     ),
//                                     Text("${hotelList!.services}"),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 8,
//                                 ),
//                                 child: Text(
//                                   "Latest Review",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 20.sp,
//                                   ),
//                                 ),
//                               ),
//                               IconButton(
//                                   onPressed: () {},
//                                   icon: Icon(Icons.arrow_forward_rounded))
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 15.0),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(20),
//                               child: Container(
//                                 height: 300.h,
//                                 width: 400,
//                                 child: GoogleMap(
//                                   compassEnabled: true,
//                                   myLocationButtonEnabled: true,
//                                   myLocationEnabled: true,
//                                   initialCameraPosition: CameraPosition(
//                                       target: LatLng(
//                                           double.parse(
//                                               "${hotelList!.latitude}"),
//                                           double.parse(
//                                               "${hotelList!.longitude}")),
//                                       zoom: 14),
//                                   markers: markers,
//                                   zoomControlsEnabled: true,
//                                   mapType: MapType.normal,
//                                   onMapCreated:
//                                       (GoogleMapController controller) {
//                                     googleMapController = controller;
//                                     setState(() {});
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Card(
//                             child: ListTile(
//                               onTap: () {
//                                 final url =
//                                     'https://www.facebook.com/mh.riyad.526';
//                                 launchUrl(Uri.parse(url));
//                               },
//                               tileColor: Colors.white12,
//                               leading: Icon(Icons.facebook_rounded),
//                               title: Text(
//                                 "Facebook Page",
//                                 style: TextStyle(),
//                               ),
//                               trailing: Icon(Icons.arrow_forward_ios),
//                             ),
//                           ),
//                           Card(
//                             child: ListTile(
//                               tileColor: Colors.white12,
//                               leading: Icon(Icons.my_library_books_rounded),
//                               title: Text(
//                                 "Visit Website",
//                                 style: TextStyle(),
//                               ),
//                               trailing: Icon(Icons.arrow_forward_ios),
//                             ),
//                           ),
//                           Card(
//                             child: ListTile(
//                               tileColor: Colors.white12,
//                               leading: Icon(Icons.my_library_books_rounded),
//                               title: Text(
//                                 "Privacy Policy",
//                                 style: TextStyle(),
//                               ),
//                               trailing: Icon(Icons.arrow_forward_ios),
//                             ),
//                           ),
//                           Card(
//                             child: ListTile(
//                               tileColor: Colors.white12,
//                               leading: Icon(Icons.headset_mic_outlined),
//                               title: Text(
//                                 "How to Claim?",
//                                 style: TextStyle(),
//                               ),
//                               trailing: Icon(Icons.arrow_forward_ios),
//                             ),
//                           ),
//                           Card(
//                             child: ListTile(
//                               tileColor: Colors.white12,
//                               leading: Icon(
//                                 Icons.headset_mic_outlined,
//                               ),
//                               title: Text(
//                                 "Help & Support",
//                                 style: TextStyle(),
//                               ),
//                               trailing: Icon(Icons.arrow_forward_ios),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
