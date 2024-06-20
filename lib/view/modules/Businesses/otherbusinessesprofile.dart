import 'package:bizfuel/model/businessregistration.dart';
import 'package:bizfuel/view/widgets/boxtile.dart';
import 'package:bizfuel/view/widgets/chat_page.dart';
import 'package:flutter/material.dart';

class OtherBusinessProfile extends StatefulWidget {
  BusinesRegistrationModel business;
  OtherBusinessProfile({super.key, required this.business});

  @override
  State<OtherBusinessProfile> createState() => _OtherBusinessProfileState();
}

class _OtherBusinessProfileState extends State<OtherBusinessProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back, color: Colors.black)),
                const SizedBox(
                  width: 90,
                ),
                const Text(
                  "Other Business",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(widget.business.image),
              backgroundColor: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            boxtile(widget.business.businessName.toUpperCase()),
            const SizedBox(
              height: 20,
            ),
            boxtile(widget.business.email),
            const SizedBox(
              height: 20,
            ),
            boxtile(widget.business.phonenumber),
            const SizedBox(
              height: 20,
            ),
            boxtile(widget.business.type),
            const SizedBox(
              height: 20,
            ),
            // const Text(
            //   "More Info lets chat",
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(
            //   height: 40,
            // ),
            // SizedBox(
            //     width: 200,
            //     height: 50,
            //     child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //             backgroundColor:
            //                 const Color.fromARGB(255, 31, 162, 136),
            //             foregroundColor: Colors.black,
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10))),
            //         onPressed: () {
            //           // Navigator.push(context,
            //           //     MaterialPageRoute(builder: (context) => Chats()));
            //         },
            //         child: const Text(
            //           "Chat",
            //           style:
            //               TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            //         )))
          ],
        ),
      ),
    ));
  }

 
}
