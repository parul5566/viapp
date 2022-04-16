import 'package:flutter/material.dart';

import '../const/AppColors.dart';


Widget customButton (String buttonText,onPressed){
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(
      buttonText,
      style: TextStyle(
          color: Colors.white, fontSize: 18),
    ),
    style: ElevatedButton.styleFrom(
      primary: AppColors.deep_orange,
      elevation: 5,
    ),
  );
}