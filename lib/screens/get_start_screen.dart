import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/screens/bottom_nav-bar.dart';
import 'package:travel_app/screens/social_login_screen.dart';

class GetStartPage extends StatefulWidget {
  static const String routeName = '/getstart_screen';
  const GetStartPage({Key? key}) : super(key: key);

  @override
  State<GetStartPage> createState() => _GetStartPageState();
}

class _GetStartPageState extends State<GetStartPage> {
  void initState() {
    isLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "images/3.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Image.asset(
                "images/logo.png",
                height: 80.h,
                width: 80.w,
              ),
            ),
            Spacer(),
            Text(
              textAlign: TextAlign.center,
              "Welcom to the\nworld of Discounts",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              textAlign: TextAlign.center,
              "Make your travel simple. Get awesome deals and save\nmore than 60% of travel cost! Enjoy your Traveling!",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Container(
                height: 2.h,
                width: 100.w,
                color: Colors.white70,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 60.0, right: 44, left: 44),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, SocialLoginPage.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Get Start Now",
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
                color: Color(0xff08BA64),
                height: 56.h,
                minWidth: 300.w,
              ),
            ),
          ],
        ),
      ),
    );
  }

  isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    if (token != null) {
      Navigator.pushNamed(context, BottomNavigationBarPage.routeName);
    }
  }
}
