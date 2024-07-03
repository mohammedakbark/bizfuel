import 'package:bizfuel/model/requestmodel.dart';
import 'package:bizfuel/model/userregitrationmodel.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/widgets/boxtile.dart';
import 'package:bizfuel/view/widgets/chat_page.dart';
import 'package:bizfuel/view/widgets/cus_rating.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Send_request extends StatelessWidget {
  UserRegModel user;
  bool isFromExisting;
  Send_request({super.key, required this.user, required this.isFromExisting});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Reseller Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(user.image),
                radius: 60,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomRating(
                  initalRating: CustomRating.ratings(user.rating.toDouble()),
                  isConst: true),
              const SizedBox(
                height: 20,
              ),
              boxtile(user.name),
              const SizedBox(
                height: 20,
              ),
              boxtile(user.email),
              const SizedBox(
                height: 20,
              ),
              boxtile(user.qualification),
              const SizedBox(
                height: 20,
              ),
              isFromExisting
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 78, 189, 178)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage(
                                  anotherUserId: user.id!,
                                  anotherUserProfile: user.image,
                                  anotherUsername: user.name,
                                  contactNumber: user.contactNumber,
                                  isThisBusinessProfile: false,
                                )));
                      },
                      child: const Text(
                        "Chat",
                        style: TextStyle(color: Colors.white),
                      ))
                  : StreamBuilder<DocumentSnapshot>(
                      stream:
                          FirebaseHelper().checkAlreadyRequestedOrNot(user.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Helper.showIndicator();
                        }

                        if (!snapshot.hasData) {
                          return const SizedBox();
                        }
                        RequestModel? requestModel;
                        bool isRequested;
                        if (snapshot.data!.exists) {
                          isRequested = true;
                          requestModel = RequestModel.fromjosn(
                              snapshot.data!.data() as Map<String, dynamic>);
                        } else {
                          isRequested = false;
                        }
                        return ElevatedButton(
                          onPressed: () {
                            if (isRequested != true) {
                              FirebaseHelper().sendNewRequest(user.id);
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: isRequested
                                  ? const MaterialStatePropertyAll(
                                      Color.fromARGB(199, 121, 121, 121))
                                  : const MaterialStatePropertyAll(
                                      Color.fromARGB(255, 78, 189, 178))),
                          child: Text(
                            requestModel != null
                                ? requestModel.requestStatus == "Accepted"
                                    ? "Accepted"
                                    : "Requested"
                                : isRequested
                                    ? "Requested"
                                    : "Request",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      })
            ],
          ),
        ),
      ),
    );
  }
}
