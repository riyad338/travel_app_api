import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
                                  child: Icon(Icons.youtube_searched_for),
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
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month_outlined),
                                      Text("Change Date")
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text("More"),
                                    Icon(Icons.arrow_forward_ios)
                                  ],
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
                                    Text("${hotelList!.services}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    Text("${hotelList!.services}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    Text("${hotelList!.services}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    Text("${hotelList!.services}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    Text("${hotelList!.services}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    Text("${hotelList!.services}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    Text("${hotelList!.services}"),
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
                                  icon: Icon(Icons.arrow_forward_rounded))
                            ],
                          ),
                          Card(
                            child: ListTile(
                              onTap: () {
                                final url =
                                    'https://www.facebook.com/mh.riyad.526';
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
                            child: ListTile(
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
                            child: ListTile(
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
