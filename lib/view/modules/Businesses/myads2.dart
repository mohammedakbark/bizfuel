import 'package:flutter/material.dart';

class Myads2 extends StatefulWidget {
  const Myads2({super.key});

  @override
  State<Myads2> createState() => _Myads2State();
}

class _Myads2State extends State<Myads2> {
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
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 140,
                  width: 140,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/watch1.jpg"))),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 140,
                  width: 140,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/watch2.jpg"))),
                )
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Center(
                child: Container(
              height: 40,
              width: 320,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(1.0, 2.0),
                        blurRadius: 3.0,
                        spreadRadius: 0.0),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: const Center(child: Text("Premium Watches")),
            )),
            const SizedBox(
              height: 30,
            ),
            Center(
                child: Container(
              height: 40,
              width: 320,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(1.0, 2.0),
                        blurRadius: 3.0,
                        spreadRadius: 0.0),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: const Center(child: Text("Kerala,Manjeri")),
            )),
            const SizedBox(
              height: 30,
            ),
            Center(
                child: Container(
                    height: 100,
                    width: 320,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(1.0, 2.0),
                              blurRadius: 3.0,
                              spreadRadius: 0.0),
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all()),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          "These watches have smaller diameter dials compared to standered watches,typically ranging from around 28mm to 36mm in diameter"),
                    ))),
          ],
        ),
      )),
    );
  }
}
