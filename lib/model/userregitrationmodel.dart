class UserRegModel {
  String email;
  String name;
  // List image;
  String image;
  String qualification;
  String? id;
  String type;

  String uid;
  String joinDate;

  UserRegModel({
    required this.email,
    required this.name,
    required this.image,
    required this.qualification,
    this.id,
    required this.joinDate,
    required this.type,
    required this.uid,
  });

  Map<String, dynamic> toJsone(idd) => {
        'email': email,
        'name': name,
        'image': image,
        'joinDate': joinDate,
        'qualification': qualification,
        'id': idd,
        'type': type,
        'uid': uid
      };

  factory UserRegModel.fromjsone(Map<String, dynamic> jsone) {
    return UserRegModel(
      joinDate: jsone["joinDate"],
      email: jsone['email'],
      name: jsone['name'],
      image: jsone['image'],
      qualification: jsone['qualification'],
      id: jsone['id'],
      type: jsone['type'],
      uid: jsone['uid'],
    );
  }
}
