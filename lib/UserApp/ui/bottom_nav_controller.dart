import 'package:flutter/material.dart';
import 'package:viapp/PradhaanApp/screens/notifi_cation.dart';
import 'package:viapp/UserApp/screens/compl_aint.dart';
import 'package:viapp/UserApp/screens/contacts.dart';
import 'package:viapp/UserApp/screens/map_screen.dart';
import 'package:viapp/UserApp/ui/complaint_screen.dart';
import 'package:viapp/UserApp/ui/phone_otp_screen.dart';
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
     NotificationPage(),
    const Profile(),
    const SearchScreen(),
     ComplaintPage1(),
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
              icon: Icon(Icons.filter_list), label: ("Complaint List")),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important),
            label: ("Notification"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: ("Profile"),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: ("Search"),
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: ("List"),
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