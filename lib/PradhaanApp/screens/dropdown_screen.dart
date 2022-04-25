/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';




class DropList extends StatefulWidget {
  @override
  _DropListState createState() => _DropListState();
}

class _DropListState extends State<DropList> {
  var carMake,carMakeModel;
  var setDefaultMake = true, setDefaultMakeModel = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('carMake: $carMake');
    debugPrint('carMakeModel: $carMakeModel');
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('carMake')
                    .orderBy('name')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  // Safety check to ensure that snapshot contains data
                  // without this safety check, StreamBuilder dirty state warnings will be thrown
                  if (!snapshot.hasData) return Container();
                  // Set this value for default,
                  // setDefault will change if an item was selected
                  // First item from the List will be displayed
                  if (setDefaultMake) {
                    carMake = snapshot.data?.docs[0].get('name');
                    debugPrint('setDefault make: $carMake');
                  }
                  return DropdownButton(
                    isExpanded: false,
                    value: carMake,
                    items: snapshot.data?.docs.map((value) {
                      return DropdownMenuItem(
                        value: value.get('name'),
                        child: Text('${value.get('name')}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      debugPrint('selected onchange: $value');
                      setState(
                            () {
                          debugPrint('make selected: $value');
                          // Selected value will be stored
                          carMake = value;
                          // Default dropdown value won't be displayed anymore
                          setDefaultMake = false;
                          // Set makeModel to true to display first car from list
                          setDefaultMakeModel = true;
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: carMake != null
                  ? StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('cars')
                    .where('make', isEqualTo: carMake)
                    .orderBy("makeModel").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    debugPrint('snapshot status: ${snapshot.error}');
                    return Text(
                        'snapshot empty carMake: $carMake cars: $carMakeModel');
                  }
                  if (setDefaultMakeModel) {
                    carMakeModel = snapshot.data!.docs[1 ].get('makeModel');
                    debugPrint('setDefault makeModel: $carMakeModel');
                  }
                  return DropdownButton(
                    isExpanded: false,
                    value: carMakeModel,
                    items: snapshot.data!.docs.map((value) {
                      debugPrint('makeModel: ${value.get('makeModel')}');
                      return DropdownMenuItem(
                        value: value.get('makeModel'),
                        child: Text(
                          '${value.get('makeModel')}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      debugPrint('makeModel selected: $value');
                      setState(
                            () {
                          // Selected value will be stored
                          carMakeModel = value;
                          // Default dropdown value won't be displayed anymore
                          setDefaultMakeModel = false;
                        },
                      );
                    },
                  );
                },
              )
                  : Container(
                child: Text('carMake null carMake: $carMake makeModel: $carMakeModel'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viapp/UserApp/const/AppColors.dart';
import 'package:viapp/UserApp/widgets/customButton.dart';
import 'package:viapp/UserApp/widgets/myTextField.dart';



class ComplaintForm extends StatefulWidget {
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  TextEditingController _genderController = TextEditingController();

  TextEditingController _ageController = TextEditingController();
  TextEditingController _currentaddressController = TextEditingController();
  TextEditingController _permanentaddressController = TextEditingController();

  List<String> gender = ["Male", "Female", "Other"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

  sendUserDataToDB()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("Pradhan-form-data");
    return _collectionRef.doc(currentUser!.email).set({
      "name":_nameController.text,
      "phone":_phoneController.text,
      "dob":_dobController.text,
      "gender":_genderController.text,
      "age":_ageController.text,
      "currentaddress":_currentaddressController.text,
      "permanentaddress":_permanentaddressController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Submit the form to continue.",
                  style:
                  TextStyle(fontSize: 22, color: AppColors.deep_orange),
                ),
                Text(
                  "We will not share your information with anyone.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBBBBBB),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                myTextField("enter your name",TextInputType.text,_nameController),
                myTextField("enter your phone number",TextInputType.number,_phoneController),
                TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "date of birth",
                    suffixIcon: IconButton(
                      onPressed: () => _selectDateFromPicker(context),
                      icon: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
                TextField(
                  controller: _genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "choose your gender",
                    prefixIcon: DropdownButton<String>(
                      items: gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                          onTap: () {
                            setState(() {
                              _genderController.text = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {

                      },
                    ),
                  ),
                ),
                myTextField("enter your age",TextInputType.number,_ageController),
                SizedBox(
                  height: 15,
                ),
                myTextField("enter your currentaddresss",TextInputType.text,_currentaddressController),
                SizedBox(
                  height: 15,
                ),
                myTextField("enter your permanentaddress",TextInputType.text,_permanentaddressController),
                SizedBox(
                  height: 50,
                ),
                // elevated button
                customButton("Continue",()=>sendUserDataToDB()
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

