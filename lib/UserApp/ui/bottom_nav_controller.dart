import 'package:flutter/material.dart';
import 'package:viapp/PradhaanApp/screens/bottom_nav.dart';
import 'package:viapp/UserApp/screens/contacts.dart';
import 'package:viapp/UserApp/screens/map_screen.dart';
import 'package:viapp/UserApp/ui/search_screen.dart';

import '../const/AppColors.dart';

import 'bottom_nav_pages/profile.dart';


class BottomNavController extends StatefulWidget {
  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _pages = [
    UserPage(),
    const Contacts(),
    const NotificationP(),
    const Profile(),
    const SearchScreen(),
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "E-Commerce",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: AppColors.deep_orange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ("Home"),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_list), label: ("User List")),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important),
            label: ("Notification"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: ("Person"),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: ("Search"),
          ),

        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
