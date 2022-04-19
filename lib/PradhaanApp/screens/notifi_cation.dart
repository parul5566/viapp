
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
   NotificationPage({Key? key}) : super(key: key);
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Notification'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        /*  SizedBox(height: 10),*/
      /*    Align(
            alignment: Alignment.topLeft,
            child: Text('Notifications',style: TextStyle(
              fontWeight: FontWeight.bold,

            ),),
          ),*/

          SizedBox(height: 10),
          Image.asset('assets/notification.png',width: 100),

          SizedBox(height: 20),

          Align(
              alignment: Alignment.center,
              child: Text('You have no notification this time ')),
        ],
      ),
    );
  }
}



