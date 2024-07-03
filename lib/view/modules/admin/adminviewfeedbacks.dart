import 'package:bizfuel/model/feeback_model.dart';
import 'package:bizfuel/view/modules/admin/feedbackpage.dart';
import 'package:bizfuel/view/modules/admin/widget.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminViewfeedBack extends StatefulWidget {
  const AdminViewfeedBack({super.key});

  @override
  State<AdminViewfeedBack> createState() => _AdminViewSecurityState();
}

class _AdminViewSecurityState extends State<AdminViewfeedBack> {
  List<Map<String, String>> data = [
    {
      "name": "Shiva",
      "type": "Swigg",
      "room": "D-303",
      "img":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6iUVzhZCoi1gffBwqglkcayiWsNQDl-Ld3PZIDZGhEqqdljJeo4ocVt8dJGgEnkRIIa4&usqp=CAU"
    },
    {
      "name": "Raman",
      "type": "Uber",
      "room": "F-506",
      "img":
          "https://images.pexels.com/photos/428364/pexels-photo-428364.jpeg?auto=compress&cs=tinysrgb&w=600"
    },
    {
      "name": "Stepn",
      "type": "Visitor",
      "room": "G-456",
      "img":
          "https://images.sftcdn.net/images/t_app-cover-l,f_auto/p/e76d4296-43f3-493b-9d50-f8e5c142d06c/2117667014/boys-profile-picture-screenshot.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned.fill(
        child: Image.asset(
          'images/background.jpg',
          fit: BoxFit.cover,
        ),
      ),
      Column(children: [
        Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )),
              topAppBar(context)
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("Feedback").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<FeedbackModel> listOfFeeedbac = [];
              listOfFeeedbac = snapshot.data!.docs
                  .map((e) =>
                      FeedbackModel.fromjson(e.data() as Map<String, dynamic>))
                  .toList();
              if (!snapshot.hasData) {
                return const SizedBox();
              }
              return Expanded(
                child: ListView.builder(
                    itemCount: listOfFeeedbac.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                          future: listOfFeeedbac[index].fromModule == "Reseller"
                              ? FirebaseHelper().getSelectedReSellerProfile(
                                  listOfFeeedbac[index].uid)
                              : FirebaseHelper().getSelectedBusinesprofile(
                                  listOfFeeedbac[index].uid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox();
                            }
                            Map<String, dynamic> doc =
                                snapshot.data!.data() as Map<String, dynamic>;

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: SizedBox(
                                width: double.infinity,
                                height: 100,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            listOfFeeedbac[index].fromModule ==
                                                    "Reseller"
                                                ? doc["image"]
                                                : doc["image"]),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 17.0, left: 10),
                                      child: Column(
                                        children: [
                                          Text(listOfFeeedbac[index]
                                                      .fromModule ==
                                                  "Reseller"
                                              ? doc["name"]
                                              : doc["businesname"]),
                                          Text(listOfFeeedbac[index]
                                                      .fromModule ==
                                                  "Reseller"
                                              ? doc["email"]
                                              : doc["email"]),
                                          Text(listOfFeeedbac[index]
                                                      .fromModule ==
                                                  "Reseller"
                                              ? doc["qualification"]
                                              : doc["phonenumber"])
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: 120,
                                      height: 40,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              foregroundColor: Colors.black,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.zero)),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AdminFeedbackPage(
                                                          image: doc["image"],
                                                          name: listOfFeeedbac[index]
                                                      .fromModule ==
                                                  "Reseller"
                                              ? doc["name"]
                                              : doc["businesname"],
                                                          data: listOfFeeedbac[
                                                              index],
                                                        )));
                                          },
                                          child: const Text("View")),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }),
              );
            }),
      ])
    ]));
  }
}
