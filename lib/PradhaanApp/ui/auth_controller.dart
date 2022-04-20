/*
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viapp/UserApp/screens/map_screen.dart';
import 'package:viapp/UserApp/ui/login_screen.dart';

class AuthController {
  static login(Map userData) async {
    print(userData);
    var response = {"user_id": "99", "user_token": "xx8894jjdsdhsuur"};
    var any = await SharedPreferences.getInstance();

    any.setString("userData", json.encode(response));
    Get.off(UserPage());
  }

  Future<bool> tryAutoLogin() async {
    var any = await SharedPreferences.getInstance();
    if (!any.containsKey("userData")) {
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
*/

import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future createCache(String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("password", password);
  }

  Future readCache(String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString("password");
    return cache;
  }

  Future removeCache(String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("password");
  }
}
