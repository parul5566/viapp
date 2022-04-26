import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ComplaintPage1 extends StatefulWidget {
  const ComplaintPage1({Key? key}) : super(key: key);

  @override
  _ComplaintPage1State createState() => _ComplaintPage1State();
}

class _ComplaintPage1State extends State<ComplaintPage1> {
  var inputText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        /*constraints: BoxConstraints.expand(),*/
       /* decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/village1.png"),
              fit: BoxFit.cover),
        ),*/
        child: SafeArea(

          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
            decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.black),
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.black)),
                  onChanged: (val) {
                    setState(() {
                      inputText = val;
                      print(inputText);
                    });
                  },
                ),
                Expanded(
                  child: Container(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Complaints")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Something went wrong"),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Text("Loading"),
                            );
                          }

                          return ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              return Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(data['name']),
                                  subtitle: Text(data["number"]),
                                ),
                              );
                            }).toList(),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
