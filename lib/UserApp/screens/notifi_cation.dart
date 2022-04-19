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

       appBar: AppBar(automaticallyImplyLeading: false,),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset('assets/icon.png',width: 200),

              SizedBox(height: 20),

              Align(
                  alignment: Alignment.center,
                  child: Text('You will find all your notification here. let"s get you started ,'
                      'go ahead and submit a complaint!')),
            ],
          ),
        ),
      ),
    );
  }
}



