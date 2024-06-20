import 'package:bizfuel/model/businesstypemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Myads2 extends StatefulWidget {
  BusinesPost post;
  Myads2({super.key, required this.post});

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
            SizedBox(
              height: 140,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(widget.post.images[index]))),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 20,
                      ),
                  itemCount: widget.post.images.length),
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
              child: Center(child: Text(widget.post.businesname)),
            )),
            SizedBox(
              height: 30,
            ),
            Center(
                child: Container(
              height: 40,
              width: 320,
              decoration: BoxDecoration(
                  boxShadow: [
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
              child: Center(child: Text(widget.post.location)),
            )),
            SizedBox(
              height: 30,
            ),
            Center(
                child: Container(
                    // height: 100
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
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          "Description:\n${widget.post.description}\n\nKey Features:\n${widget.post.keyfeature}"),
                    ))),
          ],
        ),
      )),
    );
  }
}
