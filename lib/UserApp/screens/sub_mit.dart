
import 'package:flutter/material.dart';
import 'package:viapp/UserApp/screens/track_locataion.dart';

class SuccessPage extends StatefulWidget {
   SuccessPage({Key? key}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {


  int _currentIndex = 0;


  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/icon.png',width: 30),
              Text('Village Complaint App'),
              Image.asset('assets/icon.png',width: 30),
            ],
          ),
        ),
      ),


   /*   bottomNavigationBar: BottomNavigationBar(
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
            label: "Track",
            icon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            label: "NotificationPage",
            icon: Icon(Icons.notifications),
          ),

        ],
      ),*/


      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Image.asset('assets/marks.png',width: 200),

            SizedBox(height: 20),

            Align(
                alignment: Alignment.center,
                child: Text(' Your complaint has been submitted!')),
            Text('this is your complaint'),

            Container(
              width: 100,
              child: new SizedBox(
                width: 200.0,
                child: ElevatedButton(
                  child: Text('OK'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  TrackPage()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
