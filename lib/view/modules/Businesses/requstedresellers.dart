import 'dart:developer';

import 'package:bizfuel/model/requestmodel.dart';
import 'package:bizfuel/model/userregitrationmodel.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/modules/Businesses/business_request_detail.dart';
import 'package:bizfuel/view/modules/Businesses/sentrequest.dart';
import 'package:bizfuel/view/modules/Resellers/resellerrequst.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Requested_resellers());
}

class Requested_resellers extends StatefulWidget {
  const Requested_resellers({super.key});

  @override
  State<Requested_resellers> createState() => _Requested_resellersState();
}

class _Requested_resellersState extends State<Requested_resellers> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Sheffeq());
  }
}

class Sheffeq extends StatefulWidget {
  const Sheffeq({super.key});

  @override
  State<Sheffeq> createState() => _SheffeqState();
}

class _SheffeqState extends State<Sheffeq> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.only(left: 60, top: 10),
              child: Row(
                children: [
                  Icon(Icons.arrow_back),
                  Text(
                    "Requested Resellers",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(top: 30, left: 5, right: 5),
            //   child: SizedBox(
            //       height: 40,
            //       child: SearchBar(
            //         hintText: "Find resellers",
            //         hintStyle: MaterialStatePropertyAll(
            //             TextStyle(color: Colors.black45, fontSize: 14)),
            //         leading: Icon(Icons.search),
            //       )),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseHelper().getCurrentUserRequest(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Helper.showIndicator();
                    }

                    List<RequestModel> reqest = [];
                    reqest = snapshot.data!.docs
                        .map((e) => RequestModel.fromjosn(e.data()))
                        .toList();

                    if (snapshot.hasData) {
                      return reqest.isEmpty
                          ? Center(
                              child: Text("No Request Found"),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(5),
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: FutureBuilder(
                                      future: FirebaseHelper()
                                          .getSelectedReSellerProfile(
                                              reqest[index].sendeId),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const SizedBox();
                                        }
                                        UserRegModel model =
                                            UserRegModel.fromjsone(
                                                snapshot.data!.data()
                                                    as Map<String, dynamic>);
                                        return ListTile(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      RequestDeatilOfBusiness(
                                                        requestId: reqest[index]
                                                            .requestId!,
                                                      ))),
                                          tileColor: Colors.white,
                                          leading: CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(model.image),
                                            radius: 20,
                                          ),
                                          title: Text(
                                            "Name:${model.name}",
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          subtitle: Text(
                                            "Business Type:${model.qualification}",
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                          trailing: const Icon(Icons.more_vert),
                                        );
                                      }),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: reqest.length);
                    } else {
                      return const SizedBox();
                    }
                  }),
            )
          ]),
        ),
      )),
    );
  }
}
