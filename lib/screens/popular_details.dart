import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/modal_sheet/claimed_discount_page.dart';
import 'package:travel_app/custom_widget/world.dart';
import 'package:travel_app/models/popular_deals.dart';
import 'package:travel_app/providers/home-page_provider.dart';
import 'package:travel_app/providers/hotel_provider.dart';
import 'package:travel_app/screens/location_permission.dart';
import 'package:travel_app/utils/constance.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/hotel_model.dart';

class PopularDetails extends StatefulWidget {
  static const String routeName = '/popular_detail';

  PopularDetails({Key? key}) : super(key: key);

  @override
  State<PopularDetails> createState() => _PopularDetailsState();
}

class _PopularDetailsState extends State<PopularDetails> {
  GoogleMapController? mapController;
  late GoogleMapController googleMapController;

  Set<Marker> markers = {};
  PopularDeals? popularDeals;

  String? name;
  String? id;
  String? lat;
  String? lon;

  var p = 0.017453292519943295;
  var a = 0.5;
  var b;
  double? distance;
  late HomePageProvider homePageProvider;

  void didChangeDependencies() {
    homePageProvider = Provider.of<HomePageProvider>(context);
    homePageProvider.popularDeal();
    final argList = ModalRoute.of(context)!.settings.arguments as List;

    popularDeals = argList[0];
    name = argList[1];
    id = argList[2].toString();
    lat = argList[3];
    lon = argList[4];

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
                      "https://ddtravels.safafirm.com/${popularDeals!.photo}",
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
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                      ),
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
                              onPressed: () {
                                determinePosition().then((value) => {
                                      print(
                                          "................................${value.latitude}"),
                                      b = a -
                                          cos((double.parse("${lat!}") -
                                                      value.latitude) *
                                                  p) /
                                              2 +
                                          cos(value.latitude! * p) *
                                              cos(double.parse("${lat!}") *
                                                  p!) *
                                              (1 -
                                                  cos((double.parse("${lon!}") -
                                                          value.longitude!) *
                                                      p)) /
                                              2,
                                      distance = 12742 * asin(sqrt(b)),
                                      print(
                                          "..............................ffrrfrd........................${distance}"),
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (builder) {
                                            return ClaimedDiscountPage(
                                              distance: distance,
                                            );
                                          })
                                    });
                              },
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
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => World()));
                        },
                        child: Container(
                            width: 50,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Text(
                              "Hotel",
                              style: mytextstyle(
                                  Colors.white, 12, FontWeight.w400),
                            ))),
                      ),
                    ],
                  )),
              Positioned(
                top: 150.h,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  height: 680.h,
                  width: 414.w,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
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
                                "${popularDeals!.location}",
                                style: mytextstyle(
                                    Color(0xff9C9C9C), 12, FontWeight.w400),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "${popularDeals!.description}...\nRed More..",
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
                                    Text("${popularDeals!.services}",
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
                                      "${popularDeals!.services}",
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
                                    Text("${popularDeals!.services}",
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
                                    Text("${popularDeals!.services}",
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
                                    Text("${popularDeals!.services}",
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
                                    Text("${popularDeals!.services}",
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
                                    Text("${popularDeals!.services}",
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
                                              "${popularDeals!.latitude}"),
                                          double.parse(
                                              "${popularDeals!.longitude}")),
                                      zoom: 14),
                                  markers: Set<Marker>.of([
                                    Marker(
                                        icon: BitmapDescriptor.defaultMarker,
                                        markerId:
                                            MarkerId("${popularDeals!.name}"),
                                        infoWindow: InfoWindow(
                                            title: popularDeals!.name),
                                        position: LatLng(
                                            double.parse(
                                                "${popularDeals!.latitude}"),
                                            double.parse(
                                                "${popularDeals!.longitude}")))
                                  ]),
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
                                final url = "${popularDeals!.facebookPage}";
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              onTap: () {
                                final url = "${popularDeals!.websiteLink}";
                                launchUrl(Uri.parse(url));
                              },
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
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
