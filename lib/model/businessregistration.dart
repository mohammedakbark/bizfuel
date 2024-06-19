class BusinesRegistrationModel {
  String email;
  String image;
  String phonenumber;
  String businessName;
  String password;
  String? id;
  String uid;
  String type;

  BusinesRegistrationModel({
    required this.image,
    required this.phonenumber,
    required this.businessName,
    required this.password,
    this.id,
    required this.uid,
    required this.email,
    required this.type,
  });

  Map<String, dynamic> toJsone(idd) => {
        'image': image,
        'phonenumber': phonenumber,
        'businesname': businessName,
        'password': password,
        'id': idd,
        'uid': uid,
        'email': email,
        'type':type,
      };

  factory BusinesRegistrationModel.fromjsone(Map<String, dynamic> jsone) {
    return BusinesRegistrationModel(
      image: jsone['image'],
      phonenumber: jsone['phonenumber'],
      businessName: jsone['businesname'],
      password: jsone['password'],
      id: jsone['id'],
      uid: jsone['uid'],
      email: jsone['email'],
      type: jsone['type'],
    );
  }
}
