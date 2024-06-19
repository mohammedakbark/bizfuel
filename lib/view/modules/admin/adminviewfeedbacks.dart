import 'package:bizfuel/view/modules/admin/feedbackpage.dart';
import 'package:flutter/material.dart';

class AdminViewfeedBack extends StatefulWidget {
  const AdminViewfeedBack({super.key});

  @override
  State<AdminViewfeedBack> createState() => _AdminViewSecurityState();
}

class _AdminViewSecurityState extends State<AdminViewfeedBack> {
  List<Map<String, String>> data = [
    {
      "name": "Shiva",
      "type": "Swigg",
      "room": "D-303",
      "img":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6iUVzhZCoi1gffBwqglkcayiWsNQDl-Ld3PZIDZGhEqqdljJeo4ocVt8dJGgEnkRIIa4&usqp=CAU"
    },
    {
      "name": "Raman",
      "type": "Uber",
      "room": "F-506",
      "img":
          "https://images.pexels.com/photos/428364/pexels-photo-428364.jpeg?auto=compress&cs=tinysrgb&w=600"
    },
    {
      "name": "Stepn",
      "type": "Visitor",
      "room": "G-456",
      "img":
          "https://images.sftcdn.net/images/t_app-cover-l,f_auto/p/e76d4296-43f3-493b-9d50-f8e5c142d06c/2117667014/boys-profile-picture-screenshot.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned.fill(
        child: Image.asset(
          'images/background.jpg',
          fit: BoxFit.cover,
        ),
      ),
      Column(children: [
        Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'About Us',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Contact Us',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(data[index]['img']!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 17.0, left: 10),
                          child: Column(
                            children: [
                              Text(data[index]['name']!),
                              Text(data[index]["type"]!),
                              Text(data[index]["room"]!)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 190),
                          child: SizedBox(
                            width: 120,
                            height: 40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FeedbackPage()));
                                },
                                child: Text("View")),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ])
    ]));
  }
}
