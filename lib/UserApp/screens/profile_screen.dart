/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';


class ProfilePage extends StatefulWidget {
  ProfilePageState createState() => new ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {



  late String firstName, uid, email, userphotourl;

  bool loggedIn = false;
  Future<Null> _function() async {
    SharedPreferences prefs;

    prefs = await SharedPreferences.getInstance();
    this.setState(() {
      if (prefs.getString("username") != null) {
        loggedIn = true;
        firstName = prefs.getString("username");
        uid = prefs.getString("userid");
        email = prefs.getString("useremail");
        userphotourl = prefs.getString("userphotourl");
      } else {
        loggedIn = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
//   print(username);
//   print(userid);
//   print(useremail);
//   print(userphotourl);
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Profile"),
        ),
        body: new Container(
          alignment: Alignment.center,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: userphotourl,
                  height: 150.0,
                  width: 150.0,
                  fadeInDuration: const Duration(milliseconds: 1000),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.contain,
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
                child: new Text(
                  firstName,
                  style: new TextStyle(
                      fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
              ),
              new Text(
                email,
                style: new TextStyle(fontSize: 18.0,color: Colors.blueAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this._function();
  }
}


*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viapp/PradhaanApp/model/user_model.dart';
import 'package:viapp/PradhaanApp/screens/button.dart';
import 'package:viapp/PradhaanApp/screens/constants.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {




  @override
  Widget build(BuildContext context) {




    final formkey = GlobalKey<FormState>();
    final _auth = FirebaseAuth.instance;
    String email = '';
    String name = '';
    String address= '';
    String password = '';
    bool isloading = false;

    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      // Title
      title: Text("Profile"),
    ),
      body: isloading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Form(
        key: formkey,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.grey[200],
                child: SingleChildScrollView(
                  padding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 100,
                          child: Image.asset(
                            "assets/icon.png",
                            fit: BoxFit.contain,
                          )),
                      const SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value.toString().trim();
                        },
                        validator: (value) => (value!.isEmpty)
                            ? ' Please enter email'
                            : null,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail),
                          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          name = value.toString().trim();
                        },
                        validator: (value) => (value!.isEmpty)
                            ? ' Please enter Name'
                            : null,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          address = value.toString().trim();
                        },
                        validator: (value) => (value!.isEmpty)
                            ? ' Please enter Address'
                            : null,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Permanent Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          address = value.toString().trim();
                        },
                        validator: (value) => (value!.isEmpty)
                            ? ' Please enter Address'
                            : null,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Current Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Password";
                          }
                        },
                        onChanged: (value) {
                          password = value;
                        },
                        textAlign: TextAlign.left,
                        maxLength: 10,
                        decoration: kTextFieldDecoration.copyWith(

                            hintText: 'Choose a Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            )),

                      ),
                      SizedBox(height: 80),
                      LoginSignupButton(
                        title: 'Update',
                        ontapp: () async {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              isloading = true;
                            });
                            try {
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.blueGrey,
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Sucessfully Update.'),
                                  ),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                              Navigator.of(context).pop();

                              setState(() {
                                isloading = false;
                              });
                            } on FirebaseAuthException catch (e) {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title:
                                  Text(' Ops! Update Failed'),
                                  content: Text('${e.message}'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text('Okay'),
                                    )
                                  ],
                                ),
                              );
                            }
                            setState(() {
                              isloading = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}





