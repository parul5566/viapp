/*

import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  var documents;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Complaints").snapshots(),
          builder: (context , snapshot){


            return ListView.builder(itemCount:snapshot.data!.documents.length, itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot complaints = snapshot.data!.documents[index];
              return ListTile(
                leading: Text(complaints['name']),
                title: Text(complaints['number']),
                subtitle: Text(complaints['query']),

              );
            }, );
          }
      ),
    );
  }
}
*/
