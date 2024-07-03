import 'package:bizfuel/utils/login_preference.dart';
import 'package:flutter/material.dart';

Widget topAppBar(context) {
  return Row(
    children: [
      TextButton(
        onPressed: () {},
        child: const Text(
          'About Us',
          style: TextStyle(color: Colors.black),
        ),
      ),
      TextButton(
        onPressed: () {},
        child: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.black),
        ),
      ),
      TextButton(
        onPressed: () {
          LoginPreference.clearPreference(context);
        },
        child: const Text(
          'Logout',
          style: TextStyle(color: Colors.black),
        ),
      ),
    ],
  );
}
