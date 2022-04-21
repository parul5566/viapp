import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:viapp/UserApp/const/AppColors.dart';
import 'package:viapp/UserApp/ui/bottom_nav_controller.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SmsAutoFill smsAutoFill = SmsAutoFill();
  late String strVerificationId;
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController phoneNumEditingController = TextEditingController();
  TextEditingController smsEditingController = TextEditingController();
  bool showVerifyNumberWidget = true;
  bool showVerificationCodeWidget = false;
  bool showSuccessWidget = false;

  @override
  void initState() {
    super.initState();
    getCurrentNumber();
  }

  getCurrentNumber() async {
    phoneNumEditingController.text = (await smsAutoFill.hint)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        body: Center(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                if(showVerifyNumberWidget) TextFormField(
                  controller: phoneNumEditingController,

                  decoration: const InputDecoration(
                    hintText: "Enter Phone number",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF414041),
                    ),
                    labelText: 'Enter Phone number',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: AppColors.deep_orange,
                    ),
                  ),

               /*   decoration: const InputDecoration(
                      labelText: 'Enter Phone number'),*/


                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 5,
                ),
                if(showVerifyNumberWidget) Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    child: Text("Verify Number", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                    onPressed: () async {
                      phoneNumberVerification();
                    },
                  ),
                ),
                if(showVerificationCodeWidget) TextFormField(
                  controller: smsEditingController,
                  decoration: const InputDecoration(labelText: 'Verification code'),
                ),
                SizedBox(
                  height: 10,
                ),
                if(showVerificationCodeWidget) Container(
                  padding: const EdgeInsets.only(top: 16.0),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () async {
                        signInWithPhoneNumber();
                      },
                      child: Text("Sign in", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white))
                  ),
                ),
                if(showSuccessWidget) Text(' but Your profile is pending!', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ));
  }

  Future<void> phoneNumberVerification() async {
    PhoneVerificationCompleted phoneVerificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await firebaseAuth.signInWithCredential(phoneAuthCredential);
      displayMessage(
          "Phone number is automatically verified and user signed in: ${firebaseAuth.currentUser!.uid}");
      setState(() {
        showVerifyNumberWidget = false;
        showVerificationCodeWidget = false;
        showSuccessWidget = true;
      });
    };

    PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException authException) {
      displayMessage('Phone number verification is failed. Code: ${authException.code}. Message: ${authException.message}');
    };

    PhoneCodeSent phoneCodeSent =
        (String verificationId, [int? forceResendingToken]) async {
      displayMessage('Please check your phone for the verification code.');
      strVerificationId = verificationId;
      setState(() {
        showVerifyNumberWidget = false;
        showVerificationCodeWidget = true;
      });
    } as PhoneCodeSent;

    PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verificationId) {
      displayMessage("verification code: " + verificationId);
      strVerificationId = verificationId;
      setState(() {
        showVerifyNumberWidget = false;
        showVerificationCodeWidget = true;
      });
    };

    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumEditingController.text,
          timeout: const Duration(seconds: 5),
          verificationCompleted: phoneVerificationCompleted,
          verificationFailed: phoneVerificationFailed,
          codeSent: phoneCodeSent,
          codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
    } catch (e) {
      displayMessage("Failed to Verify Phone Number: ${e}");
    }
  }

  void displayMessage(String message) {
    globalKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
  }

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: strVerificationId,
        smsCode: smsEditingController.text,
      );

      final User? user = (await firebaseAuth.signInWithCredential(credential)).user;

     /* displayMessage("Successfully signed in UID: ${user!.uid}");*/
      if(user!.uid.isNotEmpty){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>BottomNavController()));
      }
      setState(() {
        showVerificationCodeWidget = false;
        showSuccessWidget = true;
      });
    } catch (e) {
      displayMessage("Failed to sign in: " + e.toString());
    }
  }
}