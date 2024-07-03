import 'package:bizfuel/view/modules/admin/adminviewbusiness.dart';
import 'package:bizfuel/view/modules/admin/adminviewfeedbacks.dart';
import 'package:bizfuel/view/modules/admin/adminviewresellers.dart';
import 'package:bizfuel/view/modules/admin/widget.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    topAppBar(context)
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 300,
                      color: Colors.transparent,
                      child: ListView(
                        padding: const EdgeInsets.all(16.0),
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.arrow_forward_ios_outlined),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminViewBuz()));
                                      },
                                      child: const Text(
                                        "View Business",
                                        style: TextStyle(color: Colors.black),
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.arrow_forward_ios_rounded),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminViewResellers()));
                                      },
                                      child: const Text(
                                        "View Resellers",
                                        style: TextStyle(color: Colors.black),
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.arrow_forward_ios_rounded),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminViewfeedBack()));
                                      },
                                      child: const Text(
                                        "View Feedback",
                                        style: TextStyle(color: Colors.black),
                                      ))
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // Main content area (empty for now)
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
