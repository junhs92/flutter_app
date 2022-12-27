import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HelperFunctions{

  static String userLoggedInKey = "USERLOGGEDINKEY";

  static saveUserLoggedInDetails({required bool isLoggedIn}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(userLoggedInKey, isLoggedIn);
  }

  static Future<bool?> getUserLoggedInDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggedInKey);
  }
}