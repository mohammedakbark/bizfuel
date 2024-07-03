import 'dart:developer';

import 'package:bizfuel/utils/login_preference.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/login/login.dart';
import 'package:bizfuel/view/modules/Businesses/edit_profile.dart';
import 'package:bizfuel/view/widgets/feedback_page.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List<String> details = ["abcd@gmail.com", "9992345345", "Elegent Watches"];

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
                              const Icon(Icons.arrow_back),
                              const SizedBox(
                                width: 80,
                              ),
                              const Text(
                                'Accounts',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfile()));
                                  },
                                  child: const Text("Edit")),
                              TextButton(
                                  onPressed: () async {
                                    LoginPreference.clearPreference(context);
                                  },
                                  child: const Icon(Icons.logout))
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
                            child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            helper.selectedBusinessdata!.image,
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
                                  height: 45,
                                  width: 299,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                      child: Text(
                                    helper.selectedBusinessdata!.businessName,
                                    style: TextStyle(fontSize: 18),
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
                                    helper.selectedBusinessdata!.email,
                                    style: TextStyle(fontSize: 18),
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
                                    helper.selectedBusinessdata!.phonenumber,
                                    style: TextStyle(fontSize: 18),
                                  )),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 90),
                                  child: Consumer<FirebaseHelper>(
                                    builder: (context, helper, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FeebackPage(
                                                        module: "Business",
                                                      )));
                                        },
                                        child: Container(
                                          height: 45,
                                          width: 299,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
