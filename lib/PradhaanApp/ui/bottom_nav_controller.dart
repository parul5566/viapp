import 'package:flutter/material.dart';
import 'package:viapp/PradhaanApp/screens/bottom_nav.dart';
import 'package:viapp/PradhaanApp/screens/contacts.dart';
import 'package:viapp/PradhaanApp/screens/main_screen.dart';
import 'package:viapp/PradhaanApp/screens/notifi_cation.dart';
import 'package:viapp/UserApp/const/AppColors.dart';
import 'package:viapp/UserApp/ui/search_screen.dart';


import 'bottom_nav_pages/profile.dart';


class BottomNavController1 extends StatefulWidget {
  @override
  _BottomNavController1State createState() => _BottomNavController1State();
}

class _BottomNavController1State extends State<BottomNavController1> {
  final _pages = [
    const HomePage(),
     const ComplaintList(),
   /*   NotificationPage(),*/
    const PradhaanProfile(),
   /* const SearchScreen(),*/
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

          /*BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: ("Search"),
          ),*/

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
