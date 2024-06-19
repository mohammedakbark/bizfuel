import 'package:bizfuel/view/modules/Businesses/myads2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Myads1 extends StatefulWidget {
  const Myads1({super.key});

  @override
  State<Myads1> createState() => _Myads1State();
}

class _Myads1State extends State<Myads1> {
  List<Map<String, String>> data = [
    {
      "name": "Elegent Watches",
      "location": "Manjari,Kerala",
      "img":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6iUVzhZCoi1gffBwqglkcayiWsNQDl-Ld3PZIDZGhEqqdljJeo4ocVt8dJGgEnkRIIa4&usqp=CAU"
    },
    {
      "name": "Raman",
      "location": "Kochi,Kerala",
      "img":
          "https://wallpapers.com/images/featured/cool-profile-picture-87h46gcobjl5e4xu.jpg"
    },
    {
      "name": "Stepn",
      "location": "Visitor",
      "img":
          "https://images.sftcdn.net/images/t_app-cover-l,f_auto/p/e76d4296-43f3-493b-9d50-f8e5c142d06c/2117667014/boys-profile-picture-screenshot.png"
    },
  ];
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
        child: Column(
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
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 5, right: 5),
              child: SizedBox(
                  height: 30,
                  child: SearchBar(
                    hintText: "Products",
                    hintStyle: MaterialStatePropertyAll(
                        TextStyle(color: Colors.black45, fontSize: 14)),
                    leading: Icon(Icons.search),
                  )),
            ),
            const SizedBox(
              height: 35,
            ),
            Expanded(
              child: Center(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Myads2()));
                          },
                          child: Card(
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          NetworkImage(data[index]['img']!),
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
                                        Text(data[index]['name']!),
                                        Text(data[index]['location']!),
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
            ),
          ],
        ),
      )),
    );
  }
}
