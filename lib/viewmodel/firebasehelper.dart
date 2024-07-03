import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bizfuel/model/businessregistration.dart';
import 'package:bizfuel/model/businesstypemodel.dart';
import 'package:bizfuel/model/feeback_model.dart';
import 'package:bizfuel/model/requestmodel.dart';
import 'package:bizfuel/model/userregitrationmodel.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseHelper with ChangeNotifier {
  double? rating;
  updateRating(rate) {
    rating = rate;
  }

  final businessname = TextEditingController();
  final contactnumber = TextEditingController();
  final keyfeature = TextEditingController();
  final discription = TextEditingController();

  final location = TextEditingController();

  clear() {
    businessname.clear();
    keyfeature.clear();
    discription.clear();
    location.clear();
    contactnumber.clear();

    listOfImageUrl = [];
    listOfImages = [];
    notifyListeners();
  }

  // ===================  set====================//

  Future addBusinessReg(
      BusinesRegistrationModel businesRegistration, uid) async {
    final snapshot = db.collection('BusinessRegistration').doc(uid);

    snapshot.set(businesRegistration.toJsone(snapshot.id));
  }

  Future addsellerRegister(UserRegModel uSerRegitration, uid) async {
    final snapshot = db.collection('Usergegitration').doc(uid);

    snapshot.set(uSerRegitration.toJsone(snapshot.id));
  }

  Future addBusinesPost(BusinesPost businesPost) async {
    final snapshot = db.collection('BusinesPost').doc();

    snapshot.set(businesPost.toJsone(snapshot.id));
    isLoading = false;
    notifyListeners();
  }

  Future editBusinessPost(postId, BusinesPost post) async {
    await db.collection('BusinesPost').doc(postId).update(post.toJsone(postId));
  }

  deletemyad(postId) async {
    await db.collection('BusinesPost').doc(postId).delete();
  }

  File? selectimage;
  String? url;
  List<File> listOfImages = [];
  clearUrl() {
    url = null;
  }

  pickMultipleImage() async {
    listOfImages = [];
    final pickeimage = await ImagePicker().pickMultiImage();
    if (pickeimage.isEmpty) return null;

    for (var i in pickeimage) {
      listOfImages.add(File(i.path));
    }
    notifyListeners();
  }

  bool isLoading = false;
  List<String> listOfImageUrl = [];
  Future storeMultipleImages(List<File> list) async {
    isLoading = true;
    notifyListeners();
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    int index = 0;
    for (var i in list) {
      Timestamp timestamp = Timestamp.now();
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child('Businesspost/${timestamp.toString() + index.toString()}')
          .putFile(i, metadata);
      TaskSnapshot snapshot = await uploadTask;

      url = await snapshot.ref.getDownloadURL();
      listOfImageUrl.add(url!);
      index++;
    }
  }

  Future pickimage() async {
    final pickeimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickeimage == null) return null;

    selectimage = File(pickeimage.path);
    notifyListeners();

    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');

    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('BusinessProfile/$time')
        .putFile(selectimage!, metadata);

    TaskSnapshot snapshot = await uploadTask;

    url = await snapshot.ref.getDownloadURL();
    notifyListeners();
    log('this provider image url  $url');
  }

  // ===================  get====================//

  Stream<QuerySnapshot> getAllPostForSellers() {
    return db.collection('BusinesPost').snapshots();
  }

//-------------------------------------------------------//
//-----------------------------USER----------------------//
//-------------------------------------------------------//

  UserRegModel? selectedUserData;
  Future<DocumentSnapshot<Map<String, dynamic>>> getSelectedReSellerProfile(
      uid) async {
    final snapshot = await db.collection('Usergegitration').doc(uid).get();

    if (snapshot.exists) {
      selectedUserData =
          UserRegModel.fromjsone(snapshot.data() as Map<String, dynamic>);
    }
    return snapshot;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return db.collection('Usergegitration').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNewUsers() {
    return db
        .collection('Usergegitration')
        // .where("joinDate", isEqualTo: date)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getExistingUsers() {
    return db
        .collection('Usergegitration')
        .where("joinDate", isNotEqualTo: date)
        .snapshots();
  }

//-------------------------------------------------------//
//-----------------------------BUSINESS----------------------//
//-------------------------------------------------------//
  BusinesRegistrationModel? selectedBusinessdata;
  Future<DocumentSnapshot<Map<String, dynamic>>> getSelectedBusinesprofile(
      uid) async {
    final snapshot = await db.collection('BusinessRegistration').doc(uid).get();

    if (snapshot.exists) {
      selectedBusinessdata = BusinesRegistrationModel.fromjsone(
          snapshot.data() as Map<String, dynamic>);
    }
    return snapshot;
  }

  Stream<QuerySnapshot> getAllWithoutCurrentBusines() {
    return db
        .collection('BusinessRegistration')
        .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getAllBusines() {
    return db.collection('BusinessRegistration').snapshots();
  }

  Future getCurrentBusinessMessagedUsers() async {
    final snapshot = await db.collection("chat_room").get();
    print(snapshot.docs.length.toString());
    // for (var i in snapshot.docs) {
    //   log("3");
    //   log(i.id.contains(FirebaseAuth.instance.currentUser!.uid).toString());
    // }
  }

  //-------------------------------------------------------//
//-----------------------------P O S T----------------------//
//-------------------------------------------------------//

  Future getSelectedPostData(id) async {
    return await db.collection("BusinesPost").doc(id).get();
  }

  Future<QuerySnapshot> getSelectedCategoryPost(category) {
    return db
        .collection("BusinesPost")
        .where("type", isEqualTo: category)
        .get();
  }

//--------------------------R E Q U E S T----------------------
  sendNewRequest(
    receverId,
  ) {
    List<String> ids = [FirebaseAuth.instance.currentUser!.uid, receverId];

    ids.sort();

    String requestIDs = ids.join('_');

    RequestModel model = RequestModel(
      receiverId: receverId,
      requestStatus: "Requested",
      sendeId: FirebaseAuth.instance.currentUser!.uid,
    );
    final id = db.collection("Request").doc(requestIDs);
    id..set(model.tojson(requestIDs));
  }

  Stream<DocumentSnapshot> checkAlreadyRequestedOrNot(anotherUserId) {
    List<String> ids = [anotherUserId, FirebaseAuth.instance.currentUser!.uid];

    ids.sort();

    String requestIDs = ids.join('_');
    return db.collection("Request").doc(requestIDs).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentUserRequest() {
    return db
        .collection("Request")
        .where("receiverId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  Stream<DocumentSnapshot> getSelectedRequest(id) {
    return db.collection("Request").doc(id).snapshots();
  }

  changeRequestStatus(
    id,
    newStatus,
  ) async {
    if (newStatus == "Rejected") {
      await db.collection("Request").doc(id).delete();
    } else {
      await db
          .collection("Request")
          .doc(id)
          .update({"requestStatus": newStatus});
    }
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>>
      getCurrentUserAcceptedRequest() async {
    final snapshot = await db
        .collection("Request")
        // .where("requestId",
        //     arrayContains: [FirebaseAuth.instance.currentUser!.uid])
        .where("requestStatus", isEqualTo: "Accepted")
        .get();

    return snapshot.docs
        .where((element) => element["requestId"]
            .toString()
            .contains(FirebaseAuth.instance.currentUser!.uid))
        .toList();
  }

  List<DocumentSnapshot<Map<String, dynamic>>> listOfUsersForChat = [];
  getChatpossibleUsers(String collection) async {
    log("message");
    await getCurrentUserAcceptedRequest().then((value) async {
      listOfUsersForChat = [];
      // searchResult = [];
      // notifyListeners();

      if (collection == "BusinessRegistration") {
        //user module
        for (var i in value) {
          String id = i["sendeId"] != FirebaseAuth.instance.currentUser!.uid
              ? i["sendeId"]
              : i["receiverId"];
          log(id);
          final snapshot =
              await db.collection('BusinessRegistration').doc(id).get();
          listOfUsersForChat.add(snapshot);
        }
      } else if (collection == "Usergegitration") {
        for (var i in value) {
          String id = i["sendeId"] != FirebaseAuth.instance.currentUser!.uid
              ? i["sendeId"]
              : i["receiverId"];
          log(id);

          final snapshot = await db.collection('Usergegitration').doc(id).get();

          listOfUsersForChat.add(snapshot);
        }
      }
      //get sender ID
    });
  }

  Stream<QuerySnapshot> getMyPost() {
    return db
        .collection("BusinesPost")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }
  // Future<QuerySnapshot<Map<String, dynamic>>> chatroom() async {
  //   return  db.collection("chat_room").get();
  // }

  //  getlatestChatForBusiness() {
  //   chatroom().then((value) {
  //   for(var i in value.docs){

  //   }
  //   });
  // }
  //=============================//===================================//
  //==================================================================//
  //=============================//===================================//
  //------------------RESELLER----------------

  //------------------BUSINESS--------------
  // List<DocumentSnapshot<Map<String, dynamic>>> searchData = [];
  // getDataForSearch() async {
  //   searchData = listOfUsersForChat;
  //   notifyListeners();
  // }
//-------------search reseller
  List<DocumentSnapshot<Map<String, dynamic>>> searchResult = [];
  Future searchResellerByName(
      bool isSearchingUserforBusiness, String key) async {
    searchResult = [];
    searchResult = List.from(listOfUsersForChat);
    notifyListeners();
    if (isSearchingUserforBusiness == true) {
      searchResult = listOfUsersForChat
          .where((element) => element["name"]
              .toString()
              .toLowerCase()
              .contains(key.toLowerCase()))
          .toList();
    } else {
      searchResult = listOfUsersForChat
          .where((element) => element["businesname"]
              .toString()
              .toLowerCase()
              .contains(key.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }

  clearSearchList(bool listen) async {
    searchResult = [];
    listOfUsersForChat = [];
    log(searchResult.toString());
    log(listOfUsersForChat.toString());

    if (listen) {
      notifyListeners();
    }
  }
//------------search currentbusiness pst

  List<BusinesPost> postList = [];
  getMyPostForSearch() async {
    final snapshot = await db
        .collection("BusinesPost")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    postList =
        snapshot.docs.map((e) => BusinesPost.fromjsone(e.data())).toList();
  }

  List<BusinesPost> postSeachResult = [];
  searchMyPost(List<BusinesPost> list, String key) {
    postSeachResult = List.from(list);

    postSeachResult = list
        .where(
            (element) => element.type.toLowerCase().contains(key.toLowerCase()))
        .toList();
    notifyListeners();
  }

  clearads() {
    postList = [];
    // notifyListeners();
  }

  ///----------------\
  ///
  ///
  String locationForSearch = "kerala,india";

  fetSearchValue(value) {
    locationForSearch = value;
    notifyListeners();
  }

  getAllPostForSearch() async {
    final snapshot = await db
        .collection("BusinesPost")
        // .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    postList =
        snapshot.docs.map((e) => BusinesPost.fromjsone(e.data())).toList();
  }

  searchMyPostByLocation(List<BusinesPost> list, String key) {
    postSeachResult = List.from(list);

    postSeachResult = list
        .where((element) =>
            element.location.toLowerCase().contains(key.toLowerCase()))
        .toList();
    notifyListeners();
  }

  //---------------searchBusiness

  List<BusinesRegistrationModel> businessList = [];
  getBusinessForSearch() async {
    log("in");
    getChatpossibleUsers("BusinessRegistration");
    businessList = listOfUsersForChat
        .map((e) => BusinesRegistrationModel.fromjsone(
            e.data() as Map<String, dynamic>))
        .toList();
  }

  getAllBusinessForSearch() {
    final snapshot = getAllWithoutCurrentBusines();

    snapshot.listen((event) {
      businessList = event.docs
          .map((e) => BusinesRegistrationModel.fromjsone(
              e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  List<BusinesRegistrationModel> businessSearchResult = [];
  searchABusiness(List<BusinesRegistrationModel> list, String key) {
    businessSearchResult = List.from(list);

    businessSearchResult = list
        .where((element) =>
            element.businessName.toLowerCase().contains(key.toLowerCase()))
        .toList();
    notifyListeners();
  }

  //---------------feedback
  addFeddback(FeedbackModel model) {
    final dd = FirebaseFirestore.instance.collection('Feedback').doc();

    dd.set(model.toJson(dd.id));
  }

  //get all user for search
  List<UserRegModel> listOfUserForSearch = [];
  getAllUserForSearch() async {
    final snaos = await db.collection("Usergegitration").get();
    listOfUserForSearch =
        snaos.docs.map((e) => UserRegModel.fromjsone(e.data())).toList();
  }

  List<UserRegModel> userSearchResult = [];
  searchAUser(List<UserRegModel> list, String key) {
    userSearchResult = List.from(list);

    userSearchResult = list
        .where(
            (element) => element.name.toLowerCase().contains(key.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
