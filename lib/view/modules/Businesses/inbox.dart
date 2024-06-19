import 'dart:developer';

import 'package:bizfuel/model/userregitrationmodel.dart';
import 'package:bizfuel/view/widgets/chats.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Inbox());
}

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
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
          child: Consumer<FirebaseHelper>(builder: (context, helper, child) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            //Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                      ),
                      const Text(
                        "Inbox",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
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
                    child: FutureBuilder(
                        future: helper.getChatpossibleUsers("Usergegitration"),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          List<UserRegModel> list = helper.listOfUsersForChat
                              .map((e) => UserRegModel.fromjsone(
                                  e.data() as Map<String, dynamic>))
                              .toList();
                          return list.isEmpty
                              ? const Center(
                                  child: Text("No User Found"),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.all(5),
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListTile(
                                        onTap: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => Chats(
                                                      anotherUserId:
                                                          list[index].id!,
                                                      anotherUserProfile:
                                                          list[index].image,
                                                      anotherUsername:
                                                          list[index].name,
                                                      isThisBusinessProfile:
                                                          false,
                                                    ))),
                                        tileColor: Colors.white,
                                        leading: const CircleAvatar(
                                          radius: 20,
                                        ),
                                        title: Text(
                                          list[index].name,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        subtitle: Text(
                                          list[index].qualification,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        trailing: const Icon(Icons.more_vert),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemCount: list.length);
                        }),
                  )
                ]);
          }),
        ),
      )),
    );
  }
}
