import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PradhaanProfile extends StatefulWidget {
  const PradhaanProfile({Key? key}) : super(key: key);

  @override
  _PradhaanProfileState createState() => _PradhaanProfileState();
}

class _PradhaanProfileState extends State<PradhaanProfile> {
  TextEditingController ?_nameController;
  TextEditingController ?_phoneController;
  TextEditingController ?_ageController;
  TextEditingController ?_currentaddressController;
  TextEditingController ?_permanentaddressController;








  setDataToTextField(data){
    return  Column(
      children: [

        TextFormField(
          controller: _nameController = TextEditingController(text: data['name']),
        ),

        TextFormField(
          controller: _phoneController = TextEditingController(text: data['phone']),
        ),
        TextFormField(
          controller: _ageController = TextEditingController(text: data['age']),
        ),

        TextFormField(
          controller: _currentaddressController = TextEditingController(text: data['currentaddress']),
        ),

        TextFormField(
          controller: _permanentaddressController = TextEditingController(text: data['permanentaddress']),
        ),

        ElevatedButton(onPressed: ()=>updateData(), child: Text("Update"))
      ],
    );
  }

  updateData(){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
        {
          "name":_nameController!.text,
          "phone":_phoneController!.text,
          "age":_ageController!.text,
          "currentaddress":_currentaddressController!.text,
          "permanentaddress":_permanentaddressController!.text,
        }
        ).then((value) => print("Updated Successfully"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

           /* Center(
              child: SizedBox(
                  height: 100,
                  child: Image.asset(
                    "assets/icon.png",
                    fit: BoxFit.contain,
                  )),
            ),*/
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Pradhan-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              var data = snapshot.data;
              if(data==null){
                return Center(child: CircularProgressIndicator(),);
              }
              return setDataToTextField(data);
            },

              ),
            ),
          ],
        ),
      ),
    );
  }
}
