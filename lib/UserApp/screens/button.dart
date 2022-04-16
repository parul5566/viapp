import 'package:flutter/material.dart';

class LoginSignupButton extends StatelessWidget {
  final String title;
  final dynamic  ontapp;

  LoginSignupButton({required this.title, required this.ontapp});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: 
            ontapp,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),

            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
        ),
      ),
    );
  }
}