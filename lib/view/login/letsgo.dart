import 'package:bizfuel/utils/login_preference.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/login/welcome.dart';
import 'package:bizfuel/view/modules/Businesses/buzbottomsheet.dart';
import 'package:bizfuel/view/modules/Resellers/resellerbottomNavi.dart';
import 'package:bizfuel/view/modules/admin/adminhomepage.dart';
import 'package:bizfuel/view/modules/admin/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Letsgo extends StatefulWidget {
  const Letsgo({super.key});

  @override
  State<Letsgo> createState() => _LetsgoState();
}

class _LetsgoState extends State<Letsgo> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      final preference = await LoginPreference.getPreference();

     if(kIsWeb){
        if (preference.isEmpty || preference == null||preference!=ADMINUID) {
        Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) =>  AdminLoginPage()));
      }else {
        
 Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>  AdminHomePage()),
              (route) => false);
      }

     }else{
       if (preference.isEmpty || preference == null) {
        Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const WelcomePage()));
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 160),
              child: Image.asset("images/logo.png"),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: Color.fromARGB(255, 11, 177, 196),
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(20))),
            //     onPressed: () {
            //
            //     },
            //     child: Text(
            //       "Let's go",
            //       style: TextStyle(
            //           color: Color.fromARGB(255, 255, 255, 255),
            //           fontSize: 30,
            //           fontWeight: FontWeight.bold),
            //     ))
          ],
        ),
      ),
    );
  }
}
