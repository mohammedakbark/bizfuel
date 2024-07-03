import 'dart:developer';

import 'package:bizfuel/utils/login_preference.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/login/login.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final nameController = TextEditingController();
  final phoneControlller = TextEditingController();
  final qualificationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
          ),
          child: Consumer<FirebaseHelper>(
            builder: (context, helper, child) {
              return FutureBuilder(
                future: helper.getSelectedReSellerProfile(
                    FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Helper.showIndicator();
                  }
                  log('the bussines data ${snapshot.data.toString()}');

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.arrow_back)),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'Edit Profile',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                            child: InkWell(
                          onTap: () {
                            helper.pickimage().then((value) {
                              FirebaseFirestore.instance
                                  .collection("Usergegitration")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({"image": helper.url});
                            });
                          },
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              helper.selectedUserData!.image,
                            ),
                          ),
                        )),
                        SizedBox(
                          height: Helper.H(context) * .050,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  height: 45,
                                  width: 299,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            helper.selectedUserData!.email,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  height: 45,
                                  width: 299,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: helper.selectedUserData!.name,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  height: 45,
                                  width: 299,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      controller: phoneControlller,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: helper
                                            .selectedUserData!.contactNumber,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  height: 45,
                                  width: 299,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: TextFormField(
                                    controller: qualificationController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: helper
                                          .selectedUserData!.qualification,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("Usergegitration")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      "name": nameController.text.isEmpty
                                          ? helper.selectedUserData!.name
                                          : nameController.text,
                                      "contactNumber":
                                          phoneControlller.text.isEmpty
                                              ? helper.selectedUserData!
                                                  .contactNumber
                                              : phoneControlller.text,
                                      "qualification":
                                          qualificationController.text.isEmpty
                                              ? helper.selectedUserData!
                                                  .qualification
                                              : qualificationController.text,
                                    }).then((value) => setState(() {
                                              phoneControlller.clear();
                                              nameController.clear();
                                              qualificationController.clear();
                                            }));
                                  },
                                  child: Text("Update"))
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
