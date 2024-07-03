import 'package:bizfuel/utils/login_preference.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/login/lets_go.dart';
import 'package:bizfuel/view/login/welcome.dart';
import 'package:bizfuel/view/modules/Businesses/buzbottomsheet.dart';
import 'package:bizfuel/view/modules/Resellers/resellerbottomNavi.dart';
import 'package:bizfuel/view/modules/admin/adminhomepage.dart';
import 'package:bizfuel/view/modules/admin/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InitailPage extends StatefulWidget {
  const InitailPage({super.key});

  @override
  State<InitailPage> createState() => _InitailPageState();
}

class _InitailPageState extends State<InitailPage> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      // LoginPreference.clearPreference(context);
      final preference = await LoginPreference.getPreference();

      if (kIsWeb) {
        if (preference.isEmpty ||
            preference == null ||
            preference != ADMINUID) {
          Navigator.push(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(builder: (context) => AdminLoginPage()));
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => AdminHomePage()),
              (route) => false);
        }
      } else {
        if (preference.isEmpty || preference == null) {
          Navigator.push(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(builder: (context) => const Letsgo()));
        } else {
          final userdoc =
              await db.collection('BusinessRegistration').doc(preference).get();
          if (userdoc.exists) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const BizbottomNavi()),
                (route) => false);
          } else {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const ResellerbottomNavi()),
                (route) => false);
          }
        }
      }
    });

    return Scaffold(
      body: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: Center(child: appTitle),
      ),
    );
  }
}
