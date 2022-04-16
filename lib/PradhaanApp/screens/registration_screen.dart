/*
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:viapp/PradhaanApp/screens/main_screen.dart';
import '../model/user_model.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  double value  = 0;
  bool isLoading = false;
  // string for displaying the error Message
  String? errorMessage;
  bool _isHidden = true;
  bool _isObscure = true;
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //second name field
    final secondNameField = TextFormField(
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Second Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          secondNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );

    //password field
    final passwordField = TextFormField(
        maxLength: 10,

        autofocus: false,
        controller: passwordEditingController,
      obscureText: _isHidden,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,

        decoration: */
/*InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )*//*

        InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffix: InkWell(
            onTap: _togglePasswordView,
            child: Icon(
              _isHidden
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
          ),
        ),

    );

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        maxLength: 10,
        obscureText: _isObscure,
        controller: confirmPasswordEditingController,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,

        decoration: InputDecoration(

          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {

            setState(() {
              isLoading = true;
            });

            Fluttertoast.showToast(msg: "Account created successfully !",backgroundColor: Colors.green);

            signUp(emailEditingController.text, passwordEditingController.text);
            Future.delayed(const Duration(seconds: 3), (){
              setState(
                      () {
                isLoading = false;
              }
              );
            }
            );

          },
          child: isLoading? Row(
        mainAxisAlignment: MainAxisAlignment.center,

        // as elevated button gets clicked we will see text"Loading..."
        // on the screen with circular progress indicator white in color.
        //as loading gets stopped "Submit" will be displayed
        children: const [
          Text('regestering...', style: TextStyle(fontSize: 20,color: Colors.white),),
          SizedBox(width: 10,),
          CircularProgressIndicator(color: Colors.white,),
        ],
      ) : const Text(
      "SignUp",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    ),

      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 180,
                        child: Image.asset(
                          "assets/icon.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 45),
                    firstNameField,
                    SizedBox(height: 20),
                    secondNameField,
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    confirmPasswordField,

                    SizedBox(height: 20),
                    signUpButton,


                  ],
                ),
              ),
            ),

          ),
        ),
      ),
    );
  }
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;
    await firebaseFirestore
    .collection('users')
    .doc(userModel.uid)
    .set(userModel.toMap());
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage()));
    setState(() {
      isLoading = false;
    });

    Fluttertoast.showToast(
        msg: "This is toast",
        toastLength: Toast.LENGTH_LONG
    );
  }
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }



  void downloadData(){
    new Timer.periodic(
        Duration(seconds: 1),
            (Timer timer){
          setState(() {
            if(value == 1) {
              timer.cancel();
            }
            else {
              value = value + 0.1;
            }
          });
        }
    );
  }

}





*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viapp/PradhaanApp/screens/button.dart';
import 'package:viapp/PradhaanApp/screens/constants.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String name = '';
  String address = '';
  String email = '';
  String password = '';
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green,size: 30,),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Hero(
                        tag: '1',
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
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


                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter Your Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                        ),


                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          name = value.toString().trim();
                        },
                        validator: (value) => (value!.isEmpty)
                            ? ' Please enter name'
                            : null,
                        textAlign: TextAlign.left,


                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter Your name',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          address = value.toString().trim();
                        },
                        validator: (value) => (value!.isEmpty)
                            ? ' Please enter Address'
                            : null,
                        textAlign: TextAlign.left ,


                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter Your Address',
                          prefixIcon: Icon(
                            Icons.post_add,
                            color: Colors.black,
                          ),
                        ),
                      ),


                      const SizedBox(height: 30),
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
                        maxLength: 10,
                        textAlign: TextAlign.left,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Choose a Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            )),
                      ),
                      const SizedBox(height: 80),
                      LoginSignupButton(
                        title: 'Register',
                        ontapp: () async {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              isloading = true;
                            });
                            try {
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        'Sucessfully Register.You Can Login Now'),
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
                                  const Text(' Ops! Registration Failed'),
                                  content: Text('${e.message}'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text('Okay'),
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
