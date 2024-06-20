import 'package:bizfuel/model/userregitrationmodel.dart';
import 'package:bizfuel/view/widgets/chat_page.dart';
import 'package:flutter/material.dart';

class ViewReseller extends StatefulWidget {
  UserRegModel model;
  ViewReseller({super.key, required this.model});

  @override
  State<ViewReseller> createState() => _ViewResellerState();
}

class _ViewResellerState extends State<ViewReseller> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              // color: Colors.red,
              image: DecorationImage(
                  image: AssetImage(
                    "images/background.jpg",
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_outlined))
                      // Icon(Icons.arrow_back_outlined),
                      ),
                  const Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Text(
                      "Resellers Profile",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    widget.model.image,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Container(
                  height: 45,
                  width: 299,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Center(
                      child: Text(
                    widget.model.name,
                    style: TextStyle(fontSize: 18),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  height: 45,
                  width: 299,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Center(
                      child: Text(
                    widget.model.email,
                    style: TextStyle(fontSize: 18),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  height: 45,
                  width: 299,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Center(
                      child: Text(
                    widget.model.qualification,
                    style: TextStyle(fontSize: 18),
                  )),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.teal,
              //         foregroundColor: Colors.black,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(0))),
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => Chats(
              //                     anotherUserId: widget.model.id!,
              //                     anotherUserProfile: widget.model!.image,
              //                     anotherUsername: widget.model.name,
              //                     isThisBusinessProfile: false,
              //                   )));
              //     },
              //     child: const Text("Chat"))
            ],
          ),
        ),
      ),
    );
  }
}
