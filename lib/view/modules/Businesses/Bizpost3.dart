// import 'dart:developer';

// import 'package:bizfuel/model/businesstypemodel.dart';
// import 'package:bizfuel/utils/string.dart';
// import 'package:bizfuel/viewmodel/firebasehelper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// class Bizpost3 extends StatefulWidget {
//   String type;
//   Bizpost3({super.key, required this.type});

//   @override
//   State<Bizpost3> createState() => _Bizpost3State();
// }

// class _Bizpost3State extends State<Bizpost3> {
//   @override
//   Widget build(BuildContext context) {
//     final helper = Provider.of<FirebaseHelper>(context, listen: false);

//     return SafeArea(
//       child: Scaffold(
//           body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Icon(Icons.arrow_back),
//                     SizedBox(
//                       width: 80,
//                     ),
//                     Text(
//                       'Business Post',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(
//                 color: Colors.black,
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 45,
//                       backgroundColor: Colors.amberAccent,
//                     ),
//                     Text("  Name:Gadgets")
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 "   Verified Phone Number:",
//                 style: TextStyle(fontSize: 18),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Center(
//                 child: SizedBox(
//                   width: 330,
//                   child: TextFormField(
//                     inputFormatters: [LengthLimitingTextInputFormatter(10)],
//                     controller: helper.phonenumber,
//                     textAlign: TextAlign.left,
//                     decoration: const InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(vertical: 5),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 400,
//               ),
//               Center(
//                 child: SizedBox(
//                   width: 200,
//                   child: Consumer<FirebaseHelper>(
//                     builder: (context, helper, child) {
//                       return ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.teal,
//                           foregroundColor: Colors.black,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(0),
//                           ),
//                         ),
//                         onPressed: () {
//                           if (helper.url != null) {
//                             helper
//                                 .addBusinesPost(
//                               BusinesPost(
//                                 businesname: helper.businessname.text,
//                                 keyfeature: helper.keyfeature.text,
//                                 image: helper.url.toString(),
//                                 description: helper.discription.text,
//                                 type: widget.type,
//                                 phonenumber: helper.phonenumber.text,
//                                 uid: auth.currentUser!.uid,
//                               ),
//                             )
//                                 .then((value) {
//                               succestoast(context, 'ADD Post succes');
//                               helper.clear();
//                               // helper.listImage.clear();
//                             });
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content: Text('Please select ')));
//                           }
//                         },
//                         child: const Text(
//                           'Post',
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               TextButton(
//                   onPressed: () {
//                     // log(helper.listImage.toString());
//                   },
//                   child: const Text('imga '))
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
