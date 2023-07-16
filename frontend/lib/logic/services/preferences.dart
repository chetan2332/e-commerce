import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<void> saveuserDetails(String email, String password) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    log("Details Saved");
    await instance.setString("email", email);
    await instance.setString("password", password);
  }

  static Future<Map<String, String?>> fetchUserDetails() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? email = instance.getString("email");
    String? password = instance.getString("password");
    return {
      "email": email,
      "password": password,
    };
  }

  static Future<void> clear() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.clear();
  }
}
