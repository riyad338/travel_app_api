import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:travel_app/providers/home-page_provider.dart';
import 'package:travel_app/providers/hotel_provider.dart';
import 'package:travel_app/providers/latest_camp.dart';
import 'package:travel_app/providers/resturant_provider.dart';
import 'package:travel_app/screens/bottom_nav-bar.dart';
import 'package:travel_app/screens/for_you_page.dart';
import 'package:travel_app/screens/get_start_screen.dart';
import 'package:travel_app/screens/home_page.dart';
import 'package:travel_app/screens/hotel_detils_pge.dart';
import 'package:travel_app/screens/location_permission.dart';
import 'package:travel_app/screens/login_page.dart';
import 'package:travel_app/screens/profile_setup_screen.dart';
import 'package:travel_app/screens/resturant_details_page.dart';
import 'package:travel_app/screens/resturant_details_page.dart';
import 'package:travel_app/screens/search_page.dart';
import 'package:travel_app/screens/social_login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => HomePageProvider()),
    ChangeNotifierProvider(create: (context) => HotelProvider()),
    ChangeNotifierProvider(create: (context) => ResturantProvider()),
    ChangeNotifierProvider(create: (context) => LatestCampaignProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(415, 860),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: GetStartPage(),
            // home: SplashScreenPage(),
            routes: {
              LoginPage.routeName: (context) => LoginPage(),
              GetStartPage.routeName: (context) => GetStartPage(),
              SocialLoginPage.routeName: (context) => SocialLoginPage(),
              ProfileSetupPage.routeName: (context) => ProfileSetupPage(),
              HomePage.routeName: (context) => HomePage(),
              BottomNavigationBarPage.routeName: (context) =>
                  BottomNavigationBarPage(),
              SearchPage.routeName: (context) => SearchPage(),
              HotelDetailsPage.routeName: (context) => HotelDetailsPage(),
              ResturantDetailsPage.routeName: (context) =>
                  ResturantDetailsPage(),
              ForYouPage.routeName: (context) => ForYouPage(),
              ForYouPage.routeName: (context) => ForYouPage(),
            },
          );
        });
  }
}
