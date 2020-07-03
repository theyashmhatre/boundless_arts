import 'package:boundless_arts/constants.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:boundless_arts/screens/categories_page.dart';
import 'package:boundless_arts/screens/profile_page.dart';
import 'package:boundless_arts/screens/home_screen.dart';

class RoutingService extends StatefulWidget {
  @override
  _RoutingServiceState createState() => _RoutingServiceState();
}

class _RoutingServiceState extends State<RoutingService> {
  final _myPages = [
    HomePage(),
    CategoriesPage(),
    ProfilePage(),
  ];

  int _selectedPage = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: _myPages,
        onPageChanged: (index) {
          setState(() {
            _selectedPage = index;
          });
        },
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavyBar(
        topLeftRadius: 25,
        topRightRadius: 25,
        selectedIndex: _selectedPage,
        onItemSelected: (index) => setState(() {
          _selectedPage = index;
          _pageController.animateToPage(_selectedPage,
              duration: Duration(milliseconds: 300), curve: Curves.linear);
        }),
        animationDuration: Duration(milliseconds: 400),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: kSecondaryColor,
            inactiveColor: kInactiveColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.grid_on),
            title: Text('Feed'),
            activeColor: kSecondaryColor,
            inactiveColor: kInactiveColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person_pin),
            title: Text('Profile'),
            activeColor: kSecondaryColor,
            inactiveColor: kInactiveColor,
            textAlign: TextAlign.center,
          ),
        ],
        showElevation: true,
        itemCornerRadius: 20,
        curve: Curves.easeInOut,
        iconSize: 27,
        containerHeight: 57,
      ),
    );
  }
}
