import 'package:flutter/material.dart';
import 'package:travel_app/custom_widget/world.dart';
import 'package:travel_app/screens/for_you_page.dart';
import 'package:travel_app/screens/home_page.dart';
import 'package:travel_app/screens/profile_setup_screen.dart';
import 'package:travel_app/screens/search_page.dart';
import 'package:travel_app/screens/user_details_page.dart';

class BottomNavigationBarPage extends StatefulWidget {
  static const String routeName = '/bottom_nav_bar';
  const BottomNavigationBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  @override
  int? curentval;
  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    ForYouPage(),
    World(),
    UserProfile()
  ];
  int _currentindex = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.access_time,
              ),
              label: "Explore"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "images/foryou.png",
              ),
              label: "For You"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "images/world.png",
              ),
              label: "World"),
          BottomNavigationBarItem(
            icon: Image.asset(
              "images/account.png",
              color: _currentindex == true ? Colors.green : Colors.grey,
            ),
            label: "Account",
          ),
        ],
        currentIndex: _currentindex,
        onTap: (val) {
          setState(() {
            curentval = _currentindex = val;
          });

          //Handle button tap
        },
      ),
    );
  }
}
