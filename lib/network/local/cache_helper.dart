// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedPreference;

  static init() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  static Future<bool> setBooleanData({@required String key, @required bool value}) async {
    return await sharedPreference.setBool(key, value).then((value) {}).catchError((error) {
      print(error.toString());
    });
  }

  static bool getBooleanData({@required String key}){
    return sharedPreference.getBool(key);
  }
}
