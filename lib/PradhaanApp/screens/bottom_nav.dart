/*
import 'package:flutter/material.dart';

class BottomnavPage extends StatefulWidget {
  const BottomnavPage({Key? key}) : super(key: key);

  @override
  State<BottomnavPage> createState() => _BottomnavPageState();
}

class _BottomnavPageState extends State<BottomnavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
*/



import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationPage1 extends StatefulWidget {
  const NotificationPage1({Key? key}) : super(key: key);

  @override
  State<NotificationPage1> createState() => _NotificationPage1State();
}

class _NotificationPage1State extends State<NotificationPage1> {
  String notificationTitle = 'Location';
  String notificationBody = 'Person';
  String notificationData = 'No Data';

  @override
  void initState() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();
    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
    super.initState();
  }
  _changeData(String msg) => setState(() => notificationData = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Row(
            children: [
              Image.asset('assets/icon.png',width: 30),
              SizedBox(
                width : 30,
              ),
              Text('Notification'),

            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Wait for some times !",
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 20),
          Text(
            "Track Location:-  $notificationTitle",
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            "Person Name:-  $notificationBody",
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}







Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.data.containsKey('data')) {
    // Handle data message
    final data = message.data['data'];
  }if (message.data.containsKey('notification')) {
    // Handle notification message
    final notification = message.data['notification'];
  }// Or do other work.
}

class FCM {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();

  setNotifications() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    // handle when app in active state
    forgroundNotification();
    // handle when app running in background state
    backgroundNotification();
    // handle when app completely closed by the user
    terminateNotification();
    // With this token you can test it easily on your phone
    final token =
    _firebaseMessaging.getToken().then((value) => print('Token: $value'));
  }

  forgroundNotification() {
    FirebaseMessaging.onMessage.listen(
          (message) async {
        if (message.data.containsKey('data')) {
          // Handle data message
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          streamCtlr.sink.add(message.data['notification']);
        }
        // Or do other work.
        titleCtlr.sink.add(message.notification!.title!);
        bodyCtlr.sink.add(message.notification!.body!);
      },
    );
  }

  backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) async {
        if (message.data.containsKey('data')) {
          // Handle data message
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          streamCtlr.sink.add(message.data['notification']);
        }
        // Or do other work.
        titleCtlr.sink.add(message.notification!.title!);
        bodyCtlr.sink.add(message.notification!.body!);
      },
    );
  }

  terminateNotification() async {
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      if (initialMessage.data.containsKey('data')) {
        // Handle data message
        streamCtlr.sink.add(initialMessage.data['data']);
      }
      if (initialMessage.data.containsKey('notification')) {
        // Handle notification message
        streamCtlr.sink.add(initialMessage.data['notification']);
      }
      // Or do other work.
      titleCtlr.sink.add(initialMessage.notification!.title!);
      bodyCtlr.sink.add(initialMessage.notification!.body!);
    }
  }

  dispose() {
    streamCtlr.close();
    bodyCtlr.close();
    titleCtlr.close();
  }
}