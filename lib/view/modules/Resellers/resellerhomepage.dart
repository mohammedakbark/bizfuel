import 'package:bizfuel/model/businesstypemodel.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/modules/Resellers/accceptedbusinesschats.dart';
import 'package:bizfuel/view/modules/Resellers/bistypes.dart';
import 'package:bizfuel/view/modules/Resellers/reqbusiness.dart';
import 'package:bizfuel/view/modules/Resellers/viewitemdetails.dart';
import 'package:bizfuel/view/modules/Resellers/viewreqbusiness.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Resellerhomepage extends StatefulWidget {
  const Resellerhomepage({super.key});

  @override
  State<Resellerhomepage> createState() => _ResellerhomepageState();
}

class _ResellerhomepageState extends State<Resellerhomepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<FirebaseHelper>(builder: (context, searcher, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(Icons.location_on_outlined),
                  Text(
                    searcher.locationForSearch,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 27,
                  ),
                  const Spacer(),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.notifications_none_outlined,
                  //       size: 28,
                  //     )),
                ],
              ),
              SearchBar(
                onSubmitted: (value) {
                  if (value.isEmpty) {
                    searcher.fetSearchValue("   All");
                  } else {
                    searcher.fetSearchValue(value);
                  }
                },
                onTap: () {
                  searcher.getAllPostForSearch();
                },
                onChanged: (value) {
                  searcher.searchMyPostByLocation(searcher.postList, value);
                },
                hintText: "Find Businesses",
                hintStyle: const MaterialStatePropertyAll(
                    TextStyle(color: Colors.black45)),
                leading: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.search_outlined)),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text(
                    "Browse Categories",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 170,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Bistypes()));
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
              Row(
                children: [
                  InkWell(
                    child: Container(
                      height: 100,
                      width: 120,
                      color: Colors.white,
                      child: const Column(
                        children: [
                          Icon(
                            Icons.car_repair,
                            size: 100,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    child: Container(
                      height: 100,
                      width: 120,
                      color: Colors.white,
                      child: const Column(
                        children: [
                          Icon(
                            Icons.location_city_outlined,
                            size: 100,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    child: Container(
                      height: 100,
                      width: 120,
                      color: Colors.white,
                      child: const Column(
                        children: [
                          Icon(
                            Icons.mobile_friendly,
                            size: 100,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                " Fresh Recammetions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Expanded(
                // height: 480,
                child: Consumer<FirebaseHelper>(
                  builder: (context, helper, child) {
                    return StreamBuilder(
                      stream: helper.getAllPostForSellers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        List<BusinesPost> list = [];
                        if (searcher.postList.isEmpty) {
                          list = snapshot.data!.docs.map((e) {
                            return BusinesPost.fromjsone(
                                e.data() as Map<String, dynamic>);
                          }).toList();
                        } else {
                          list = searcher.postSeachResult;
                        }

                        if (!snapshot.hasData) {
                          return const Text("No Data");
                        }
                        return list.isEmpty
                            ? const Center(
                                child: Text("No Post Found"),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Viewitemdetails(
                                            businesPost: list[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          //color: Colors.white,
                                          border:
                                              Border.all(color: Colors.black)),
                                      // height: 800,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  list[index].images[0],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            list[index].businesname,
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            list[index].description,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 197, 197, 197),
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            list[index].keyfeature,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 197, 197, 197),
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
