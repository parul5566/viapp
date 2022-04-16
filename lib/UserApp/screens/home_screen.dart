import 'package:flutter/material.dart';
import 'package:viapp/PradhaanApp/screens/bottom_nav.dart';
import 'package:viapp/UserApp/screens/contacts.dart';
import 'package:viapp/UserApp/screens/map_screen.dart';
import 'package:viapp/UserApp/screens/profile_screen.dart';
import 'package:viapp/UserApp/ui/user_form.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List _screens = [
    UserPage(),
    Contacts(),
    NotificationP(),
/*    StepperDemo(),*/
    UserForm(),
  ];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _updateIndex,
        selectedItemColor: Colors.green[700],
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            label: "Submit",
            icon: Icon(Icons.join_left_rounded),
          ),
          BottomNavigationBarItem(
            label: "Complaint List",
            icon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            label: "NotificationPage",
            icon: Icon(Icons.notifications),
          ),
         /* BottomNavigationBarItem(
            label: "Status",
            icon: Icon(Icons.signal_wifi_statusbar_4_bar),
          ),*/
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: _screens[_currentIndex],

    );
  }
}