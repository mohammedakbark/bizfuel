import 'package:bizfuel/model/businesstypemodel.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/modules/Businesses/myads2.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Myads1 extends StatefulWidget {
  const Myads1({super.key});

  @override
  State<Myads1> createState() => _Myads1State();
}

class _Myads1State extends State<Myads1> {
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
        child: Consumer<FirebaseHelper>(builder: (context, searcher, child) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(
                      width: 120,
                    ),
                    Text(
                      'My Adds',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, left: 5, right: 5),
                child: SizedBox(
                    height: 30,
                    child: SearchBar(
                      onTap: () {
                        searcher.getMyPostForSearch();
                      },
                      onChanged: (value) {
                        searcher.searchMyPost(searcher.postList, value);
                      },
                      hintText: "Products",
                      hintStyle: MaterialStatePropertyAll(
                          TextStyle(color: Colors.black45, fontSize: 14)),
                      leading: Icon(Icons.search),
                    )),
              ),
              const SizedBox(
                height: 35,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseHelper().getMyPost(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Helper.showIndicator();
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No Post"));
                    }
                    List<BusinesPost> listOfMyPost = [];
                    if (searcher.postList.isNotEmpty) {
                      listOfMyPost = searcher.postSeachResult;
                    } else {
                      listOfMyPost = snapshot.data!.docs
                          .map((e) => BusinesPost.fromjsone(
                              e.data() as Map<String, dynamic>))
                          .toList();
                    }

                    return Expanded(
                      child: Center(
                        child: listOfMyPost.isEmpty
                            ? Text("No Post Found")
                            : ListView.builder(
                                itemCount: listOfMyPost.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Myads2(
                                                      post: listOfMyPost[index],
                                                    )));
                                      },
                                      child: Card(
                                        child: Container(
                                          width: double.infinity,
                                          height: 100,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(
                                                      listOfMyPost[index]
                                                          .images[0]),
                                                ),
                                                // child: Container(
                                                //   width: 60,
                                                //   height: 60,
                                                //   decoration: BoxDecoration(
                                                //       image: DecorationImage(
                                                //           image: NetworkImage(
                                                //               data[index]['img']!))),
                                                // ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 17.0, left: 10),
                                                child: Column(
                                                  children: [
                                                    Text(listOfMyPost[index]
                                                        .type),
                                                    Text(listOfMyPost[index]
                                                        .location),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                      ),
                    );
                  }),
            ],
          );
        }),
      )),
    );
  }
}
