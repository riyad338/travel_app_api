import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/models/user_model.dart';
import 'package:travel_app/providers/home-page_provider.dart';
import 'package:travel_app/utils/constance.dart';

class UserProfile extends StatefulWidget {
  static const String routeName = '/user_profile';
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late HomePageProvider homePageProvider;
  void didChangeDependencies() {
    homePageProvider = Provider.of<HomePageProvider>(context);
    img;
    homePageProvider.userdata();

    setState(() {});
    super.didChangeDependencies();
  }

  String? img;
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
                child: Image.asset("images/2.png", fit: BoxFit.cover),
                height: 200.h,
                width: double.infinity,
                color: Colors.grey,
              ),
              Positioned(
                top: 160,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30.r))),
                  height: 680,
                  width: 414.w,
                  // child: Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                  //   child: SingleChildScrollView(
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(20)),
                  //   height: 150,
                  //   width: 400,

                  //       ],
                  //     ),
                  //   ),
                  // ),
                ),
              ),

              // return Column(
              //   children: [
              //     Stack(
              //       children: [
              //         CircleAvatar(
              //           backgroundColor:
              //           Colors.grey.shade300,
              //           radius: 50.r,
              //           child: Image.network(
              //             "https://ddtravels.safafirm.com/${homePageProvider.userModel!.userInfo!.image}",
              //           ),
              //         ),

              //       ],
              //     ),

              Positioned(
                top: 60,
                child: Container(
                  height: 715,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          height: 200,
                                          width: 414,
                                        ),
                                        Positioned(
                                            top: 15,
                                            right: 10,
                                            child: Icon(
                                              Icons.edit,
                                              color: Color(0xffD0D0D0),
                                            )),
                                        Positioned(
                                            top: 35,
                                            right: 14,
                                            child: Container(
                                              height: 2,
                                              width: 18,
                                              color: Color(0xffD0D0D0),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                  top: 50,
                                  right: 0,
                                  left: 0,
                                  child: Column(
                                    children: [
                                      FutureBuilder<UserModel>(
                                          future: homePageProvider.userdata(),
                                          builder: (context, snapshot) {
                                            img =
                                                "${homePageProvider.userModel!.userInfo!.image}";

                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                child: spinkit,
                                              );
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (snapshot.data == null) {
                                              return Text(
                                                  "snapshot data are null");
                                            }
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Stack(
                                                  children: [
                                                    CircleAvatar(
                                                      child: Image.network(
                                                          "${homePageProvider.userModel!.userInfo!.image}"),
                                                      radius: 55,
                                                    ),
                                                    Positioned(
                                                        right: 1,
                                                        bottom: 0,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Color(0xff08BA64),
                                                          radius: 15,
                                                          child: Icon(
                                                            Icons.done,
                                                            color: Colors.white,
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                                Text(
                                                  "${homePageProvider.userModel!.userInfo!.name}",
                                                  style: mytextstyle(
                                                      Color(0xff131B1A),
                                                      22,
                                                      FontWeight.w500),
                                                ),
                                                Text(
                                                  "${homePageProvider.userModel!.userInfo!.address}",
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Color(0xff9C9C9C)),
                                                )
                                              ],
                                            );
                                          }),
                                    ],
                                  ))
                            ],
                          ),
                          height: 300,
                          width: 414,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            height: 214,
                            width: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xff08BA64),
                                              width: 5),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      height: 100,
                                      width: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "120",
                                            style: mytextstyle(
                                                Color(0xff08BA64),
                                                20,
                                                FontWeight.w400),
                                          ),
                                          Text(
                                            "days remaining ",
                                            textAlign: TextAlign.center,
                                            style: mytextstyle(
                                                Color(0xff9C9C9C),
                                                10,
                                                FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "12",
                                          style: mytextstyle(Color(0xff08BA64),
                                              24, FontWeight.w400),
                                        ),
                                        Text(
                                          "discounts\nclaimed",
                                          style: mytextstyle(Color(0xff9C9C9C),
                                              14, FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "45k+",
                                          style: mytextstyle(Color(0xff08BA64),
                                              24, FontWeight.w400),
                                        ),
                                        Text(
                                          "taka saved\ntraveling",
                                          style: mytextstyle(Color(0xff9C9C9C),
                                              14, FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 16),
                                      backgroundColor: Color(0xff08BA64)),
                                  onPressed: () {},
                                  child: Text(
                                    "Buy Subscription",
                                    style: mytextstyle(
                                        Color(0xffFFFFFF), 14, FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 400,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "My Disccount",
                                style: mytextstyle(
                                    Color(0xff131B1A), 20, FontWeight.w500),
                              ),
                              Container(
                                  width: 92,
                                  height: 32,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Show all"),
                                      Icon(Icons.arrow_forward_ios_rounded),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
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
