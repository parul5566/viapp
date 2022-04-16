import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viapp/UserApp/screens/main_screen.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({Key? key}) : super(key: key);

  @override
  _AddContactsState createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  late TextEditingController _nameController, _numberController,_queryController;
  String _typeSelected ='';

late DatabaseReference _ref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _queryController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('Complaints');
  }


Widget _buildContactType(String title){

  return InkWell(

    child: Container(
      height: 40,
      width: 90,

      decoration: BoxDecoration(
        color: _typeSelected == title? Colors.yellow : Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Center(child: Text(title, style: TextStyle(fontSize: 18,
      color: Colors.white),
    ),),),

    onTap: (){
      setState(() {
        _typeSelected = title;
      });
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Save Complaint'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  autofocus: false,
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Name cannot be Empty");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nameController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Enter Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
              ),


              SizedBox(height: 15),




          TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              maxLength: 10,
              controller: _numberController,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Please Enter Your Phone Number");
                }
                // reg expression for email validation
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value)) {
                  return ("Please Enter a valid phonenumber");
                }
                return null;
              },
              onSaved: (value) {
                _numberController.text = value!;
              },

              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone_iphone),
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "Enter Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
          ),



              /*TextFormField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],

                maxLength: 10,
                decoration: InputDecoration(
                  hintText: 'Enter Number',
                  prefixIcon: Icon(
                    Icons.phone_iphone,
                    size: 30,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),*/


             SizedBox(height: 15,),
               Text('Query'),
              SizedBox(height: 15,),
              TextFormField(
                controller: _queryController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter Description',
                 /* prefixIcon: Icon(
                    Icons.book_outlined,
                    size: 30,
                  ),*/
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                ),
              ),

              Center(
                child: Container(
                    height: 150,
                    child: MainPage()),
              ),

              SizedBox(height: 15,),
             Container(
               height: 40,
               child: ListView(
                 scrollDirection: Axis.horizontal,
                 children: [
                   _buildContactType('Pradhan'),
                   SizedBox(width: 10),
                   _buildContactType('BDC'),
                   SizedBox(width: 10),
                   _buildContactType('Public'),
                   SizedBox(width: 10),
                   _buildContactType('Others'),
                 ],
               ),
             ),

             SizedBox(height: 25,),

             Container(
               width: double.infinity,
               padding: EdgeInsets.symmetric(horizontal: 10),
               child: RaisedButton(child: Text('Save Complaint',style: TextStyle(
                 fontSize: 20,
                 color: Colors.white,
                 fontWeight: FontWeight.w600,
               ),),
               onPressed: (){
                 saveContact();
               },
               color: Theme.of(context).primaryColor,
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
  void saveContact(){
    String name = _nameController.text;
    String number = _numberController.text;
    String query = _queryController.text;
    Map<String,String> contact = {
      'name':name,
      'number': '+91 ' + number,
      'query':query,
      'type': _typeSelected,
    };
    _ref.push().set(contact).then((value) {
      Navigator.pop(context);
    });
  }
}





