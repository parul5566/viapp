/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageList extends StatelessWidget {
  MessageList({this.firestore});

  final Firestore firestore;
  var _mySelection;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('preciso-modelos').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return new DropdownButton<String>(
          isDense: true,
          hint: new Text("Select"),
          value: _mySelection,
          onChanged: (String newValue) {
            print (_mySelection);
          },
          items: snapshot.data!.documents.map((Map map) {
            return new DropdownMenuItem<String>(
              value: map["id"].toString(),
              child: new Text(
                map["name"],
              ),
            );
          }).toList(),
        );},
    );
  }
}*/
