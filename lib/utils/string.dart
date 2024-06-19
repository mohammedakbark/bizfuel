import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final db = FirebaseFirestore.instance;

final auth = FirebaseAuth.instance;

String time = DateFormat('h:mm a').format(DateTime.now());
String date = DateFormat("dd-MM-yyyy").format(DateTime.now());

succestoast(BuildContext context, msg) {
  CherryToast.success(title: Text(msg, style: TextStyle(color: Colors.black)))
      .show(context);
}

infotoast(BuildContext context, msg) {
  CherryToast.info(
    title: Text(msg, style: TextStyle(color: Colors.black)),
    actionHandler: () {
      print("Action button pressed");
    },
  ).show(context);
}

class Helper {
  static double W(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double H(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenRatio(BuildContext context) {
    return W(context) / H(context);

   
  }

 static Widget showIndicator(){
    return  const Center(
        child: CircularProgressIndicator(
      color: Colors.blueAccent,
      backgroundColor: Colors.white,
      strokeWidth: 4,
      strokeCap: StrokeCap.round,
    ));
  }
}
