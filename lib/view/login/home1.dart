import 'package:bizfuel/view/modules/Businesses/bizhomepage.dart';
import 'package:bizfuel/view/modules/Businesses/bizregistration.dart';
import 'package:bizfuel/view/modules/Resellers/resellregistration.dart';
import 'package:flutter/material.dart';

class Homeone extends StatefulWidget {
  const Homeone({super.key});

  @override
  State<Homeone> createState() => _HomeoneState();
}

class _HomeoneState extends State<Homeone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  "bizfuel",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 90,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Text(
                    "You are in a rigth place \n Are you...??",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: 275,
                  height: 100,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(233, 12, 12, 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Bizregistration()));
                      },
                      child: const Text(
                        "BUSINESS",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  height: 45,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        indent: 40,
                        endIndent: 10,
                        color: Colors.black45,
                        thickness: 1,
                        height: 3,
                      ),
                    ),
                    Text(
                      'OR',
                      style: TextStyle(color: Colors.black45),
                    ),
                    Expanded(
                      child: Divider(
                        indent: 10,
                        endIndent: 40,
                        color: Colors.black45,
                        thickness: 1,
                        height: 3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  height: 45,
                ),
                SizedBox(
                  width: 275,
                  height: 100,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(233, 12, 12, 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Resellregistration()));
                      },
                      child: const Text(
                        "RESELLERS",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(
                  height: 150,
                ),
                Text("Bizfuel © 2024")
              ]),
            )));
  }
}
