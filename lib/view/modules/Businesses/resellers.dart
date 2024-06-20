import 'package:bizfuel/model/userregitrationmodel.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/widgets/chat_page.dart';
import 'package:bizfuel/view/modules/Businesses/sentrequest.dart';
import 'package:bizfuel/view/modules/Resellers/resellerrequst.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Resellers extends StatefulWidget {
  const Resellers({super.key});

  @override
  State<Resellers> createState() => _ResellersState();
}

class _ResellersState extends State<Resellers> {
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
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/background.jpg"), fit: BoxFit.cover),
      ),
      child: const DefaultTabController(
        length: 2,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(left: 60, top: 10),
            child: Text(
              "Resellers",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 30, left: 5, right: 5),
          //   child: SizedBox(
          //       height: 30,
          //       child: SearchBar(
          //         hintText: "Find resellers",
          //         hintStyle: MaterialStatePropertyAll(
          //             TextStyle(color: Colors.black45, fontSize: 14)),
          //         leading: Icon(Icons.search),
          //       )),
          // ),
          TabBar(
              indicatorColor: Colors.black,
              dividerColor: Colors.black,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: "Existing",
                ),
                Tab(
                  text: "New",
                )
              ]),
          Expanded(
            child: TabBarView(children: [ExistingUsers(), NewUsers()]),
          ),
        ]),
      ),
    ));
  }
}

class NewUsers extends StatefulWidget {
  const NewUsers({
    super.key,
  });

  @override
  State<NewUsers> createState() => _NewUsersState();
}

class _NewUsersState extends State<NewUsers> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseHelper().getNewUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Helper.showIndicator();
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No Users Found"),
            );
          }
          List<UserRegModel> users = [];
          users = snapshot.data!.docs
              .map((e) =>
                  UserRegModel.fromjsone(e.data() as Map<String, dynamic>))
              .toList();
          return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Send_request(
                          isFromExisting: false,
                              user: users[index],
                            ))),
                    tileColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(users[index].image),
                      radius: 20,
                    ),
                    title: Text(
                      "Name:${users[index].name}",
                      style: TextStyle(fontSize: 12),
                    ),
                    subtitle: Text(
                      "Qualification:${users[index].qualification}",
                      style: TextStyle(fontSize: 10),
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
              itemCount: users.length);
        });
  }
}

class ExistingUsers extends StatefulWidget {
  const ExistingUsers({
    super.key,
  });

  @override
  State<ExistingUsers> createState() => _ExistingUsersState();
}

class _ExistingUsersState extends State<ExistingUsers> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseHelper>(builder: (context, helper, child) {
      return FutureBuilder(
          future: helper.getChatpossibleUsers("Usergegitration"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Helper.showIndicator();
            }
            // if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            //   return const Center(
            //     child: Text("No Users Found"),
            //   );
            // }
            List<UserRegModel> users = [];
            users = helper.listOfUsersForChat
                .map((e) =>
                    UserRegModel.fromjsone(e.data() as Map<String, dynamic>))
                .toList();
            // users = snapshot.data!.docs
            //     .map((e) =>
            //         UserRegModel.fromjsone(e.data() as Map<String, dynamic>))
            //     .toList();
            return users.isEmpty
                ? Center(
                    child: Text("No Users Found"),
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
                        child: ListTile(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Send_request(
                                    isFromExisting: true,
                                        user: users[index],
                                      ))),
                          tileColor: Colors.white,
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(users[index].image),
                            radius: 20,
                          ),
                          title: Text(
                            "Name:${users[index].name}",
                            style: TextStyle(fontSize: 12),
                          ),
                          subtitle: Text(
                            "Qualification:${users[index].qualification}",
                            style: TextStyle(fontSize: 10),
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
                    itemCount: users.length);
          });
    });
  }
}
