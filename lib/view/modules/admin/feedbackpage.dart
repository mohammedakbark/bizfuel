import 'package:bizfuel/model/feeback_model.dart';
import 'package:bizfuel/view/modules/admin/widget.dart';
import 'package:flutter/material.dart';

class AdminFeedbackPage extends StatefulWidget {
  FeedbackModel data;
  String image;
  String name;
  AdminFeedbackPage(
      {super.key, required this.data, required this.name, required this.image});
  @override
  State<AdminFeedbackPage> createState() => _AdminFeedbackPageState();
}

class _AdminFeedbackPageState extends State<AdminFeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(children: [
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
                  child: const Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )),
             topAppBar(context)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.image),
                ),
                title: Text(widget.name),
              ),
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.topLeft,
                width: double.infinity,
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(20),
                decoration:
                    BoxDecoration(border: Border.all(), color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.data.feedbackMessage),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(widget.data.timestamp!.toDate().toString())
                  ],
                ),
              )
              // const SizedBox(height: 16),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     fillColor: Colors.white,
              //     filled: true,
              //     labelText: 'Replay:',
              //     border: OutlineInputBorder(),
              //   ),
              //   maxLines: 3,
              // ),
              // const SizedBox(height: 16),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //       backgroundColor: const Color.fromARGB(255, 40, 135, 125),
              //       foregroundColor: Colors.black,
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(0))),
              //   onPressed: () {},
              //   child: const Text('Send'),
              // ),
            ],
          ),
        ),
      ]),
    ));
  }
}
