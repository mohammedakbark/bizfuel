import 'package:bizfuel/model/businessregistration.dart';
import 'package:bizfuel/model/userregitrationmodel.dart';
import 'package:bizfuel/utils/login_preference.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/modules/Businesses/buzbottomsheet.dart';
import 'package:bizfuel/view/modules/Resellers/resellerbottomNavi.dart';
import 'package:bizfuel/view/login/login.dart';
import 'package:bizfuel/view/widgets/snackbars.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthControoler with ChangeNotifier {
  Future businessRegistration(
      email, password, context, businesname, img, phonenumber) async {
    final authprvdr = Provider.of<FirebaseHelper>(context, listen: false);

    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) {
          authprvdr.addBusinessReg(
            BusinesRegistrationModel(
              businessName: businesname,
              image: img,
              password: password,
              phonenumber: phonenumber,
              uid: value.user!.uid,
              email: email,
              type: 'BUSINESS',
            ),
            value.user!.uid,
          );
          CSnackbar.showSuccessToast(context, "REGISTRATION SUCCESS");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Login(),
            ),
            (route) => false,
          );
        },
      );
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  Future signin(email, password, BuildContext context) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User? user = value.user;

        if (user != null) {
          String uid = user.uid;
          final userdoc =
              await db.collection('BusinessRegistration').doc(uid).get();

          if (userdoc.exists) {
            LoginPreference.setPreference(uid);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const BizbottomNavi()),
                (route) => false);
            CSnackbar.showSuccessToast(context, "LOGIN SUCCESS");
          } else {
            LoginPreference.setPreference(uid);

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const ResellerbottomNavi()),
                (route) => false);

            CSnackbar.showSuccessToast(context, "LOGIN SUCCESS");
          }
        }
      });
    } catch (e) {
      return CSnackbar.showErrorToast(context, e.toString());
    }
  }

  // Future signinUser(email, password, BuildContext context) async {
  //   try {
  //     UserCredential credential = await auth.signInWithEmailAndPassword(
  //         email: email, password: password);

  //     User? user = credential.user;

  //     if (user != null) {
  //       String uid = credential.user!.uid;
  //       final userdoc = await db.collection('userregitreation').doc(uid).get();

  //       if (userdoc.exists) {
  //         Navigator.of(context)
  //             .push(MaterialPageRoute(builder: (context) => BizbottomNavi()));
  //       } else {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => Check(),
  //           ),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  Future userRegitration(
    email,
    
    password,
    context,
    img,
    phonenumber,
    name,
    qaualification,
  ) async {
    final authprvdr = Provider.of<FirebaseHelper>(context, listen: false);

    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) {
          authprvdr.addsellerRegister(
              UserRegModel(
                contactNumber:phonenumber ,
                joinDate: date,
                email: email,
                name: name,
                image: img,
                qualification: qaualification,
                type: 'SELLER',
                uid: value.user!.uid,
              ),
              value.user!.uid);
          CSnackbar.showSuccessToast(context, "REGISTRATION SUCCESS");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Login(),
            ),
            (route) => false,
          );
        },
      );
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }
}
