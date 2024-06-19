import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String senderID;
  String senderEmail;
  String reciverID;
  String message;
  Timestamp timestamp;

  MessageModel({
    required this.senderID,
    required this.senderEmail,
    required this.reciverID,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> tojsone() => {
        'senderid': senderID,
        'senderemail': senderEmail,
        'message': message,
        'timestamp': timestamp,
        'reciverid': reciverID,
      };

  factory MessageModel.fromjsone(Map<String, dynamic> jsone) {
    return MessageModel(
      senderID: jsone['senderid'],
      senderEmail: jsone['senderemail'],
      reciverID: jsone['reciverid'],
      message: jsone['message'],
      timestamp: jsone['timestamp'],
    );
  }
}
