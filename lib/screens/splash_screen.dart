import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/screens/get_start_screen.dart';
import 'package:travel_app/screens/social_login_screen.dart';

class SplashScreenPage extends StatefulWidget {
  static const String routeName = '/splash_screen';
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, GetStartPage.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage("images/splash_back.png"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, GetStartPage.routeName);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 280.h),
                child: Image.asset("images/logo.png"),
              ),
            ),
            Spacer(),
            Text(
              "Travel Made Simple",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 40.h,
            )
          ],
        ),
      ),
    );
  }
}
