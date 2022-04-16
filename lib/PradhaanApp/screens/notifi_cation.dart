import 'dart:ui';
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


      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Notifications',style: TextStyle(
                fontWeight: FontWeight.bold,

              ),),
            ),
            SizedBox(height: 10),
            Image.asset('assets/icon.png',width: 200),

            SizedBox(height: 20),

            Align(
                alignment: Alignment.center,
                child: Text('You will find all your notification here. let"s get you started ,'
                    'go ahead and submit a complaint!')),
          ],
        ),
      ),
    );
  }
}



