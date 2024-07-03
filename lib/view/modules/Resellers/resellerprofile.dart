import 'dart:developer';

import 'package:bizfuel/utils/login_preference.dart';
import 'package:bizfuel/view/login/login.dart';
import 'package:bizfuel/view/modules/Resellers/edit_user_profile.dart';
import 'package:bizfuel/view/modules/admin/feedbackpage.dart';
import 'package:bizfuel/view/widgets/cus_rating.dart';
import 'package:bizfuel/view/widgets/feedback_page.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResellerProfile extends StatefulWidget {
  ResellerProfile({super.key});

  @override
  State<ResellerProfile> createState() => _ResellerProfileState();
}

class _ResellerProfileState extends State<ResellerProfile> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseHelper>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              // color: Colors.red,
              image: DecorationImage(
                  image: AssetImage(
                    "images/background.jpg",
                  ),
                  fit: BoxFit.cover)),
          child: FutureBuilder(
              future: provider.getSelectedReSellerProfile(
                  FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.skip_previous_outlined),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Text(
                            "Resellers Profile",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const EditUserProfile()));
                            },
                            child: const Text(
                              "Edit",
                              style: TextStyle(fontSize: 15),
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          provider.selectedUserData!.image,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomRating(
                        initalRating: CustomRating.ratings(
                            provider.selectedUserData!.rating.toDouble()),
                        isConst: true),
                    Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: Container(
                        height: 45,
                        width: 299,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Center(
                            child: Text(
                          provider.selectedUserData!.name,
                          style: const TextStyle(fontSize: 18),
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        height: 45,
                        width: 299,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Center(
                            child: Text(
                          provider.selectedUserData!.email,
                          style: const TextStyle(fontSize: 18),
                        )),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 30),
                    //   child: Container(
                    //     height: 45,
                    //     width: 299,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Colors.white,
                    //     ),
                    //     child:  Center(
                    //         child: Text(
                    //                                 provider.selectedUserData!.,
                    //       style: TextStyle(fontSize: 18),
                    //     )),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        height: 45,
                        width: 299,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Center(
                            child: Text(
                          provider.selectedUserData!.qualification,
                          style: const TextStyle(fontSize: 18),
                        )),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 30),
                    //   child: Container(
                    //     height: 45,
                    //     width: 299,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Colors.white,
                    //     ),
                    //     child: const Center(
                    //         child: Text(
                    //       "3 yearexp",
                    //       style: TextStyle(fontSize: 18),
                    //     )),
                    //   ),
                    // ),
                    Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Consumer<FirebaseHelper>(
                          builder: (context, helper, child) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FeebackPage(
                                          module: "Reseller",
                                        )));
                              },
                              child: Container(
                                height: 45,
                                width: 299,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: const Center(
                                    child: Text(
                                  "Feedback",
                                  style: TextStyle(fontSize: 18),
                                )),
                              ),
                            );
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Consumer<FirebaseHelper>(
                          builder: (context, helper, child) {
                            return GestureDetector(
                              onTap: () {
                                LoginPreference.clearPreference(context);
                              },
                              child: Container(
                                height: 45,
                                width: 299,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: const Center(
                                    child: Text(
                                  "logout",
                                  style: TextStyle(fontSize: 18),
                                )),
                              ),
                            );
                          },
                        )),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
