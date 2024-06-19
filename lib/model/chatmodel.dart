import 'package:bizfuel/utils/string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> sendMeassage() async {
  final String curentuserid = auth.currentUser!.uid;
  final String currentuseremail = auth.currentUser!.email.toString();
  final Timestamp timestamp = Timestamp.now();
}
