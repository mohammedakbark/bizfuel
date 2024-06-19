import 'dart:convert';

class BusinesPost {
  String businesname;
  String keyfeature;
  // List image;
  List<String> images;
  String description;
  String? id;
  String type;
  String phonenumber;
  String uid;
  String location;

  BusinesPost({
    required this.businesname,
    required this.keyfeature,
    required this.images,
    required this.description,
    this.id,
    required this.location,
    required this.type,
    required this.phonenumber,
    required this.uid,
  });

  Map<String, dynamic> toJsone(idd) => {
        'businessname': businesname,
        'location':location,
        'keyfeature': keyfeature,
        'images': images.map((e) => e),
        'description': description,
        'id': idd,
        'type': type,
        'phonenumber': phonenumber,
        'uid': uid
      };

  factory BusinesPost.fromjsone(Map<String, dynamic> jsone) {
    List<String> list = List<String>.from(jsone['images']);
    return BusinesPost(
      location:jsone["location"],
      businesname: jsone['businessname'],
      keyfeature: jsone['keyfeature'],
      images: list,
      description: jsone['description'],
      id: jsone['id'],
      type: jsone['type'],
      phonenumber: jsone['phonenumber'],
      uid: jsone['uid'],
    );
  }
}
