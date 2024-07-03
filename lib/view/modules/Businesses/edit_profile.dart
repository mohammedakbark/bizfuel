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

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final phoneControlller = TextEditingController();
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
                future: helper.getSelectedBusinesprofile(auth.currentUser!.uid),
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
                                  .collection("BusinessRegistration")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({"image": helper.url});
                            });
                          },
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              helper.selectedBusinessdata!.image,
                            ),
                            child: const Icon(
                              Icons.image_sharp,
                              color: Colors.white,
                              size: 40,
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
                                  padding: const EdgeInsets.only(left: 10),
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
                                            helper.selectedBusinessdata!.email,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
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
                                      hintText: helper
                                          .selectedBusinessdata!.businessName,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
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
                                            .selectedBusinessdata!.phonenumber,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("BusinessRegistration")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      "businesname": nameController.text.isEmpty
                                          ? helper.selectedBusinessdata!
                                              .businessName
                                          : nameController.text,
                                      "phonenumber":
                                          phoneControlller.text.isEmpty
                                              ? helper.selectedBusinessdata!
                                                  .phonenumber
                                              : phoneControlller.text
                                    }).then((value) => setState(() {
                                              phoneControlller.clear();
                                              nameController.clear();
                                            }));
                                  },
                                  child: const Text("Update"))
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
