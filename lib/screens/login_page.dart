import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/screens/bottom_nav-bar.dart';
import 'package:travel_app/screens/home_page.dart';
import 'package:travel_app/screens/profile_setup_screen.dart';
import 'package:http/http.dart' as http;
import '../utils/constance.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login_screen';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      opacity: 0.2,
      progressIndicator: spinkit,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.darken),
              image: AssetImage(
                "images/4.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Container(
              height: 850.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40.0.h),
                      child: Image.asset(
                        "images/logo.png",
                        height: 80.h,
                        width: 80.w,
                      ),
                    ),
                    SizedBox(
                      height: 320.h,
                    ),
                    Text(
                      "Email sign in",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0.h),
                      child: Container(
                        height: 2.h,
                        width: 50.w,
                        color: Colors.white70,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 33.0.w, vertical: 5.h),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field must not be empty";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid Email");
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20.w),
                            hintStyle: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp),
                            hintText: "Your email address",
                            filled: true,
                            fillColor: Colors.white70,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 33.0.w, vertical: 5.h),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field must not be empty";
                          }

                          return null;
                        },
                        obscureText: _obscureText,
                        controller: passwordController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.w),
                            hintStyle: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp),
                            hintText: "A secure password",
                            filled: true,
                            fillColor: Colors.white70,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0.h, horizontal: 132.w),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r)),
                        onPressed: () {
                          getLogin();
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        color: Color(0xff08BA64),
                        height: 50.h,
                        minWidth: 151.w,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.h, bottom: 101.0.h),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontSize: 14.sp, color: Colors.greenAccent),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;
  getLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        String url = "${baseUrl}login";
        var map = Map<String, dynamic>();
        map["email"] = emailController.text.toString();
        map["password"] = passwordController.text.toString();
        var responce = await http.post(Uri.parse(url), body: map);
        var data = jsonDecode(responce.body);

        setState(() {
          isLoading = false;
        });
        if (responce.statusCode == 200) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("token", data["token"]);

          Navigator.pushReplacementNamed(
              context, BottomNavigationBarPage.routeName);
          showInToast("Login Successfull");
        } else {
          showInToast("Email or Password doesn't match");
        }
      } catch (e) {
        print("$e");
      }
    }
  }
}
