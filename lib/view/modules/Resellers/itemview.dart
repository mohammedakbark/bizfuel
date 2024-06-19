import 'package:bizfuel/model/businesstypemodel.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/modules/Resellers/viewitemdetails.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Recommentation extends StatefulWidget {
  String type;
  Recommentation({super.key, required this.type});

  @override
  State<Recommentation> createState() => _RecommentationState();
}

class _RecommentationState extends State<Recommentation> {
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
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                  SizedBox(
                    width: 110,
                  ),
                  Text(
                    widget.type,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                child: SizedBox(
                    height: 30,
                    child: SearchBar(
                      hintText: "Find Businesses",
                      hintStyle: MaterialStatePropertyAll(
                          TextStyle(color: Colors.black45, fontSize: 14)),
                      leading: Icon(Icons.search),
                    )),
              ),
              FutureBuilder(
                  future: FirebaseHelper().getSelectedCategoryPost(widget.type),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Helper.showIndicator();
                    }
                    List<BusinesPost> listofPost = [];

                    listofPost = snapshot.data!.docs
                        .map((e) => BusinesPost.fromjsone(
                            e.data() as Map<String, dynamic>))
                        .toList();
                    return Expanded(
                      child: listofPost.isEmpty
                          ? Center(
                              child: Text("No Post"),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12),
                              itemCount: listofPost.length,
                              itemBuilder: (_, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Viewitemdetails(
                                                  businesPost:
                                                      listofPost[index],
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Colors.transparent),
                                    height: 150,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 100,
                                            width: 90,
                                            child: Image.network(
                                              listofPost[index].images[0],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Text(listofPost[index].businesname),
                                        Text(listofPost[index].description),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(listofPost[index].location)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
