import 'dart:convert';


import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viapp/UserApp/screens/home_screen.dart';
import 'package:viapp/UserApp/ui/bottom_nav_controller.dart';
import 'package:viapp/UserApp/ui/login_screen.dart';

class AuthController {
  static login(Map userData) async {
    print(userData);

    var response = {"user_id": "99", "user_token": "xx8894jjdsdhsuur"};
    var any = await SharedPreferences.getInstance();

    any.setString("users-form-data", json.encode(response));
    Get.off(BottomNavController());
  }

  Future<bool> tryAutoLogin() async {
    var any = await SharedPreferences.getInstance();
    if (!any.containsKey("users-form-data")) {
      return false;
    } else {
      // final extractedUserData =
      //     json.decode(any.getString('userData').toString());

      // print(extractedUserData['user_id']);
      // print(extractedUserData['user_token']);

      return true;
    }
  }

  static logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.off(() => LoginScreen());
  }
}
