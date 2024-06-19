import 'package:bizfuel/model/businessregistration.dart';
import 'package:bizfuel/model/requestmodel.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/widgets/boxtile.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestDeatilOfReseller extends StatelessWidget {
  String requestId;
  RequestDeatilOfReseller({super.key, required this.requestId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover),
        ),
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseHelper().getSelectedRequest(requestId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Helper.showIndicator();
              }
              if (!snapshot.hasData) {
                return const SizedBox();
              }

              RequestModel requestModel = RequestModel.fromjosn(
                  snapshot.data!.data() as Map<String, dynamic>);
              return FutureBuilder(
                  future: FirebaseHelper()
                      .getSelectedBusinesprofile(requestModel.sendeId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Helper.showIndicator();
                    }
                    BusinesRegistrationModel businesRegistrationModel =
                        BusinesRegistrationModel.fromjsone(
                            snapshot.data!.data() as Map<String, dynamic>);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(Icons.arrow_back)),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "Reseller Profile",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(businesRegistrationModel.image),
                            radius: 60,
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          boxtile(businesRegistrationModel.businessName),
                          const SizedBox(
                            height: 20,
                          ),
                          boxtile(businesRegistrationModel.email),
                          const SizedBox(
                            height: 20,
                          ),
                          boxtile(businesRegistrationModel.phonenumber),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  FirebaseHelper().changeRequestStatus(
                                    requestId,
                                    "Accepted",
                                  );
                                },
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.green)),
                                child: Text(
                                  requestModel.requestStatus != "Accepted"
                                      ? "Accept"
                                      : "Accepted",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  FirebaseHelper().changeRequestStatus(
                                    requestId,
                                    "Rejected",
                                  );
                                  Navigator.pop(context);
                                },
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 174, 22, 11))),
                                child: const Text(
                                  "Reject",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
