import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/screens/login_page.dart';
import 'package:travel_app/screens/profile_setup_screen.dart';

class SocialLoginPage extends StatefulWidget {
  static const String routeName = '/social_login_screen';
  const SocialLoginPage({Key? key}) : super(key: key);

  @override
  State<SocialLoginPage> createState() => _SocialLoginPageState();
}

class _SocialLoginPageState extends State<SocialLoginPage> {
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
              padding: const EdgeInsets.only(top: 40.0),
              child: Image.asset(
                "images/logo.png",
                height: 80.h,
                width: 80.w,
              ),
            ),
            Spacer(),
            Text(
              "Sing in to DD",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                height: 2.h,
                width: 50.w,
                color: Colors.white70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 60.0, right: 60, top: 40, bottom: 15),
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(22.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.r,
                        child: Image.asset(
                          "images/google.png",
                          height: 30.h,
                          width: 30.w,
                        )),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Continue with Google",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60.0, right: 60, bottom: 15),
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(22.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.r,
                        child: Image.asset(
                          "images/Facebook.png",
                          height: 30.h,
                          width: 30.w,
                        )),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      "Continue with Facebook",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60.0, right: 60, bottom: 45),
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(22.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.r,
                        child: Image.asset(
                          "images/Apple.png",
                          height: 30.h,
                          width: 30.w,
                        )),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      "Continue with Apple",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0, right: 110, left: 110),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.w, color: Colors.white),
                    borderRadius: BorderRadius.circular(20.r)),
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
                child: Text(
                  "Continue with Email",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                height: 46.h,
                minWidth: 300.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 37.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ProfileSetupPage.routeName);
                },
                child: Text(
                  "Skip for now",
                  style: TextStyle(color: Colors.white60, fontSize: 15.sp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
