import 'package:bizfuel/model/businessregistration.dart';
import 'package:bizfuel/model/requestmodel.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/modules/Businesses/sentrequest.dart';
import 'package:bizfuel/view/modules/Resellers/resellerrequst.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewReqBusiness extends StatefulWidget {
  const ViewReqBusiness({super.key});

  @override
  State<ViewReqBusiness> createState() => _RequestedViewBiz_resellersState();
}

class _RequestedViewBiz_resellersState extends State<ViewReqBusiness> {
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
            Padding(
              padding: const EdgeInsets.only(left: 60, top: 10),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const Text(
                    "Requested Resellers",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 5, right: 5),
              child: SizedBox(
                  height: 40,
                  child: SearchBar(
                    hintText: "Find resellers",
                    hintStyle: MaterialStatePropertyAll(
                        TextStyle(color: Colors.black45, fontSize: 14)),
                    leading: Icon(Icons.search),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseHelper().getCurrentUserRequest(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Helper.showIndicator();
                    }
                    List<RequestModel> reqest = [];
                    reqest = snapshot.data!.docs
                        .map((e) => RequestModel.fromjosn(
                            e.data() as Map<String, dynamic>))
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
                                          .getSelectedBusinesprofile(
                                              reqest[index].sendeId),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const SizedBox();
                                        }
                                        BusinesRegistrationModel model =
                                            BusinesRegistrationModel.fromjsone(
                                                snapshot.data!.data()
                                                    as Map<String, dynamic>);
                                        return ListTile(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      RequestDeatilOfReseller(
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
                                            "Name:${model.businessName}",
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          subtitle: Text(
                                            "Business Type:${model.type}",
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
