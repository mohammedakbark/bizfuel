import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedbackModel {
  String ?feedbackId;
  String? uid;
  String fromModule;
  String feedbackMessage;
  Timestamp ?timestamp;

  FeedbackModel(
      {required this.feedbackMessage,
      required this.fromModule,
       this.timestamp,
       this.feedbackId,
       this.uid});

  Map<String, dynamic> toJson(id) => {
        "feedbackMessage": feedbackMessage,
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "fromModule": fromModule,
        "feedbackId": id,
        "timestamp": Timestamp.now()
      };

  factory FeedbackModel.fromjson(Map<String, dynamic> json) {
    return FeedbackModel(
        feedbackMessage: json["feedbackMessage"],
        fromModule: json["fromModule"],
        timestamp: json["timestamp"],
        feedbackId: json["feedbackId"],
        uid: json["uid"]);
  }
}
