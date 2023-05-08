import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/models/latest_campaign.dart';
import 'package:travel_app/models/user_model.dart';
import 'package:travel_app/providers/home-page_provider.dart';
import 'package:travel_app/providers/latest_camp.dart';
import 'package:travel_app/utils/constance.dart';

class ForYouPage extends StatefulWidget {
  static const String routeName = '/foryou';

  const ForYouPage({Key? key}) : super(key: key);

  @override
  State<ForYouPage> createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {
  LatestCampaignProvider? latestCampaignProvider;
  HomePageProvider? homePageProvider;
  int status = 1;
  @override
  void didChangeDependencies() {
    homePageProvider = Provider.of<HomePageProvider>(context);
    latestCampaignProvider = Provider.of<LatestCampaignProvider>(context);
    latestCampaignProvider!.latestCampaign();
    homePageProvider?.userdata();
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: 250.w,
                        height: 60.h,
                        child: FutureBuilder<UserModel>(
                            future: homePageProvider!.userdata(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
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
                                      radius: 55.r,
                                      backgroundImage: NetworkImage(
                                          "${homePageProvider!.userModel!.userInfo!.image}"),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${homePageProvider!.userModel!.userInfo!.name}",
                                          style: mytextstyle(Color(0xff131B1A),
                                              18.sp, FontWeight.w500),
                                        ),
                                        Text(
                                          homePageProvider!.userModel!.userInfo!
                                                      .status ==
                                                  status
                                              ? "Active"
                                              : "",
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              color: Color(0xff9C9C9C)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Image.asset("images/achive.png")),
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
                          child: Icon(
                            Icons.notifications_outlined,
                            color: Color(0xff9C9C9C),
                          ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 90.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("images/dis.png"),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "My Discounts",
                            style: mytextstyle(
                                Color(0xff9C9C9C), 14.sp, FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 90.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("images/pendind.png"),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Pending Rewards",
                            style: mytextstyle(
                                Color(0xff9C9C9C), 14.sp, FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text(
                    "Ongoing Campaigns",
                    style:
                        mytextstyle(Color(0xff131B1A), 22.sp, FontWeight.w500),
                  ),
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
                FutureBuilder<LatestCampaignModel>(
                    future: latestCampaignProvider!.latestCampaign(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.data == null) {
                        return Text("snapshot data are null");
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: latestCampaignProvider!
                              .latestCampaignModel!.campaign!.length,
                          itemBuilder: (context, index) {
                            var data = latestCampaignProvider!
                                .latestCampaignModel!.campaign![index];
                            //    snapshot.data!.popularDeals![index];
                            return Padding(
                              padding: EdgeInsets.all(
                                10.0.w,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(20.r)),
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
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          "images/2.png",
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
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${data.title}",
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                "${data.type}",
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: Color(0xff9C9C9C),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              SizedBox(
                                                height: 50.h,
                                              ),
                                              Text(
                                                "${data.endDate}",
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Color(0xff08BA64),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward_ios,
                                        color: Colors.grey),
                                  ],
                                ),
                              ),
                            );
                          });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
