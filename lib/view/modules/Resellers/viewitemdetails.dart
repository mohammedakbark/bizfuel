import 'package:bizfuel/model/businesstypemodel.dart';
import 'package:bizfuel/model/requestmodel.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/modules/Businesses/businesstype.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Viewitemdetails extends StatefulWidget {
  final BusinesPost? businesPost;
  Viewitemdetails({super.key, required this.businesPost});

  @override
  State<Viewitemdetails> createState() => _ViewitemDetailsState();
}

class _ViewitemDetailsState extends State<Viewitemdetails> {
  final keyfeature = TextEditingController();
  final small = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Column(children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      const SizedBox(width: 10),
                      // const Text(

                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.businesPost!.businesname,
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.businesPost!.images.length,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.all(20),
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  widget.businesPost!.images[index],
                                )),
                            border: Border.all()),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 280),
                    child: Text("Key Features"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Helper.W(context) * .8,
                    height: Helper.H(context) * .070,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Row(
                      children: [
                        Text(widget.businesPost!.keyfeature),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 250),
                    child: Text("Small Description"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Helper.W(context) * .8,
                    height: Helper.H(context) * .070,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Row(
                      children: [
                        Text(widget.businesPost!.description),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseHelper()
                          .checkAlreadyRequestedOrNot(widget.businesPost!.uid),
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isRequested
                                  ? Colors.grey
                                  : const Color.fromARGB(255, 5, 243, 52),
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () {
                              if (isRequested == false) {
                                FirebaseHelper()
                                    .sendNewRequest(widget.businesPost!.uid);
                              }
                            },
                            child: Text(
                              requestModel != null
                                  ? requestModel.requestStatus == "Accepted"
                                      ? "Accepted"
                                      : "Requested"
                                  : isRequested
                                      ? "Requested"
                                      : "Request",
                              style: TextStyle(fontSize: 20),
                            ));
                      }),
                ]))));
  }
}
