import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/CustomHttp/customhttp.dart';
import 'package:travel_app/custom_widget/carousel_slider_home/slider.dart';
import 'package:travel_app/first-page.dart';
import 'package:travel_app/models/latest_campaign.dart';
import 'package:travel_app/models/popular_deals.dart';
import 'package:travel_app/models/user_model.dart';
import 'package:travel_app/providers/home-page_provider.dart';
import 'package:travel_app/providers/latest_camp.dart';
import 'package:travel_app/screens/login_page.dart';
import 'package:travel_app/screens/search_page.dart';
import 'package:travel_app/utils/constance.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  var _dotPosition = 0;

  late LatestCampaignProvider latestCampaignProvider;
  late HomePageProvider homePageProvider;
  ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    latestCampaignProvider = Provider.of<LatestCampaignProvider>(context);
    latestCampaignProvider.latestCampaign();

    homePageProvider = Provider.of<HomePageProvider>(context);
    homePageProvider.popularDeal();
    homePageProvider.userdata();

    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 250.w,
                          height: 60.h,
                          child: FutureBuilder<UserModel>(
                              future: homePageProvider.userdata(),
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
                                return Container(
                                  height: 60.h,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 50.r,
                                        backgroundImage: NetworkImage(
                                          "https://ddtravels.safafirm.com/${homePageProvider.userModel!.userInfo!.image}",
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${homePageProvider.userModel!.userInfo!.name}",
                                            style: mytextstyle(
                                                Color(0xff131B1A),
                                                18,
                                                FontWeight.w500),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 14.sp,
                                                color: Color(0xff9C9C9C),
                                              ),
                                              Text(
                                                "${homePageProvider.userModel!.userInfo!.address}",
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Color(0xff9C9C9C)),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Image.asset(
                            "images/scan.png",
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Icon(Icons.notifications_outlined,
                                  color: Color(0xff9C9C9C)),
                            ),
                            Positioned(
                                top: 10.h,
                                right: 15.w,
                                child: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 4.r,
                                ))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, SearchPage.routeName);
                          },
                          child: Container(
                            height: 55.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: Colors.white38,
                            ),
                            width: 290.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Where do you wanna go?",
                                  style: mytextstyle(
                                      Color(0xff9C9C9C), 16, FontWeight.w400),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.greenAccent,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.remove("token");
                            Navigator.pushNamed(context, LoginPage.routeName);
                            showInToast("Logout Successfull");
                          },

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ResturantScreen()));

                          child: Container(
                            height: 55.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Color(0xff08BA64)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wifi_tethering_error_rounded,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Emergncy",
                                  style: mytextstyle(
                                      Colors.white, 8.sp, FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "images/hotel.png",
                              height: 65.h,
                              width: 80.w,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Hotel/Resort",
                              style: mytextstyle(
                                  Color(0xff9C9C9C), 13.sp, FontWeight.w400),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset("images/res.png"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Restaurant",
                              style: mytextstyle(
                                  Color(0xff9C9C9C), 13.sp, FontWeight.w400),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset("images/jahaj.png"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Cruise",
                              style: mytextstyle(
                                  Color(0xff9C9C9C), 13.sp, FontWeight.w400),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset("images/plane.png"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Flight",
                              style: mytextstyle(
                                  Color(0xff9C9C9C), 13.sp, FontWeight.w400),
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Offers for you",
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 25.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      height: 1.h,
                      width: 100.w,
                      color: Color(0xffD0D0D0),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 270,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: FutureBuilder<LatestCampaignModel>(
                              future: latestCampaignProvider.latestCampaign(),
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
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: latestCampaignProvider!
                                        .latestCampaignModel!.campaign!.length,
                                    itemBuilder: (context, index) {
                                      var data = latestCampaignProvider!
                                          .latestCampaignModel!
                                          .campaign![index];
                                      //    snapshot.data!.popularDeals![index];
                                      return Padding(
                                        padding: EdgeInsets.all(
                                          10.0.w,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white70,
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                          height: 150.h,
                                          width: 350.w,
                                          child: Container(
                                            height: double.infinity,
                                            width: 100.w,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://ddtravels.safafirm.com/${data.photo}",
                                              width: 350,
                                              height: 250.h,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  SpinKitFadingCircle(
                                                color: Colors.greenAccent,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                "images/2.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),

                                            // NetworkImage(
                                            //     "https://ddtravels.safafirm.com/${data.photo}"),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                        ),
                        // Positioned(
                        //   bottom: 10,
                        //   left: 0,
                        //   right: 0,
                        //   child: DotsIndicator(
                        //     dotsCount: latestCampaignProvider!
                        //         .latestCampaignModel!.campaign!.length,
                        //     position: _dotPosition,
                        //     decorator: DotsDecorator(
                        //       activeColor: Colors.grey,
                        //       color: Colors.red,
                        //       spacing: EdgeInsets.all(2),
                        //       activeSize: Size(8, 8),
                        //       size: Size(6, 6),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    // CompanyList(),
                    // Container(
                    //   height: 200,
                    //   color: Colors.yellow,
                    //   child: ListView.builder(
                    //       itemCount: latestCampaignProvider!
                    //           .latestCampaignModel!.campaign!.length,
                    //       itemBuilder: (context, index) {
                    //         _carouselImages.add(
                    //             "${latestCampaignProvider!.latestCampaignModel!.campaign![index].photo}");
                    //
                    //         return AspectRatio(
                    //           aspectRatio: 3.5,
                    //           child: CarouselSlider(
                    //               items: _carouselImages
                    //                   .map((item) => Padding(
                    //                         padding: const EdgeInsets.only(
                    //                             left: 3, right: 3),
                    //                         child: Container(
                    //                           decoration: BoxDecoration(
                    //                               image: DecorationImage(
                    //                                   image:
                    //                                       NetworkImage(item),
                    //                                   fit: BoxFit.fitWidth)),
                    //                         ),
                    //                       ))
                    //                   .toList(),
                    //               options: CarouselOptions(
                    //                   autoPlay: true,
                    //                   enlargeCenterPage: true,
                    //                   viewportFraction: 0.8,
                    //                   enlargeStrategy:
                    //                       CenterPageEnlargeStrategy.height,
                    //                   onPageChanged:
                    //                       (val, carouselPageChangedReason) {
                    //                     _dotPosition = val;
                    //                   })),
                    //         );
                    //       }),
                    // ),
                    // // CarouselSlider.builder(
                    // //     itemCount: latestCampaignProvider!
                    // //         .latestCampaignModel!.campaign!.length,
                    // //
                    // //     itemBuilder: (BuildContext context, index, page) {
                    // //       _carouselImages.add("${latestCampaignProvider!
                    // //           .latestCampaignModel!.campaign!.length[page].i}");
                    // //       return Container(
                    // //         height: 200,
                    // //         width: 300,
                    // //       );
                    // //     },
                    // //     options: CarouselOptions(
                    // //         autoPlay: true,
                    // //         enlargeCenterPage: true,
                    // //         viewportFraction: 0.8,
                    // //         enlargeStrategy: CenterPageEnlargeStrategy.height,
                    // //         onPageChanged: (val, carouselPageChangedReason) {
                    // //           setState(() {
                    // //             _dotPosition = val;
                    // //           });
                    // //         })),

                    // SizedBox(
                    //   height: 10.h,
                    // ),

                    // Container(
                    //   width: double.infinity,
                    //   height: 300,
                    //   child: Image.asset(
                    //     "images/home6.png",
                    //     width: double.infinity,
                    //     height: 250..h,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular Deals",
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 25.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 1.h,
                      width: 100.w,
                      color: Color(0xffD0D0D0),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      height: 150.h,
                      width: double.infinity,
                      child: FutureBuilder<PopularDealsModel>(
                          future: homePageProvider.popularDeal(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: SpinKitFadingCircle(
                                  color: Colors.greenAccent,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.data == null) {
                              return Text("snapshot data are null");
                            }
                            return Container(
                              height: 150.h,
                              width: double.infinity,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: homePageProvider
                                      .popularDealsModel!.popularDeals!.length,
                                  // popularDealsModel!.popularDeals!.length,
                                  itemBuilder: (context, index) {
                                    var data = homePageProvider
                                        .popularDealsModel!
                                        .popularDeals![index];
                                    //    snapshot.data!.popularDeals![index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        right: 10.0.w,
                                        bottom: 10.h,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        height: 150.h,
                                        width: 400.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: double.infinity,
                                              width: 100.w,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://ddtravels.safafirm.com/${data.photo}",
                                                width: double.infinity,
                                                height: 250.h,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${data.name}",
                                                        style: TextStyle(
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            size: 14.sp,
                                                          ),
                                                          Text(
                                                            "${data.location}",
                                                            style: TextStyle(
                                                                fontSize: 13.sp,
                                                                color: Color(
                                                                    0xff9C9C9C)),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                              height: 20.h,
                                                              width: 40.w,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300),
                                                              child: Center(
                                                                  child: Text(
                                                                      "Hotel",
                                                                      style: mytextstyle(
                                                                          Color(
                                                                              0xff9C9C9C),
                                                                          13.sp,
                                                                          FontWeight
                                                                              .w400)))),
                                                          SizedBox(
                                                            width: 4.w,
                                                          ),
                                                          Container(
                                                              height: 20.h,
                                                              width: 80.w,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300),
                                                              child: Center(
                                                                  child: Text(
                                                                      "Restaurent",
                                                                      style: mytextstyle(
                                                                          Color(
                                                                              0xff9C9C9C),
                                                                          13.sp,
                                                                          FontWeight
                                                                              .w400)))),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xffF4B806),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xffF4B806),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xffF4B806),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xffF4B806),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xffF4B806),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "Review",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 11.sp),
                                                    )
                                                  ],
                                                ),
                                              ],
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
                                                  height: 40.h,
                                                  width: 40.w,
                                                  child: Center(
                                                    child: Text(
                                                      "${data.discount}%",
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Text("available offer",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 10.sp)),
                                                    Text(
                                                      "${data.offerPrice}\$",
                                                      style: mytextstyle(
                                                        Color(0xff08BA64),
                                                        15.sp,
                                                        FontWeight.w700,
                                                      ),
                                                    ),
                                                    Text(
                                                      " ${data.price}\$",
                                                      style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color:
                                                            Color(0xff08BA64),
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
