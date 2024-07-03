import 'package:bizfuel/view/login/initail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPreference {
  static setPreference(value) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    prefer.setString("key", value);
  }

  static Future<String> getPreference() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    return prefer.getString("key") ?? "";
  }

  static clearPreference(context) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    FirebaseAuth.instance.signOut().then((value) {
      prefer.remove("key");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => InitailPage()),
          (route) => false);
    });
  }
}
