// import 'package:bizfuel/utils/string.dart';
// import 'package:bizfuel/view/modules/Businesses/Bizpost3.dart';
// import 'package:bizfuel/viewmodel/firebasehelper.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Bizpost2 extends StatelessWidget {
//   String tyep;
//   Bizpost2({super.key, required this.tyep});

//   @override
//   Widget build(BuildContext context) {
//     final helper = Provider.of<FirebaseHelper>(context, listen: false);
//     return Scaffold(
//       body: Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
//           ),
//           child: SingleChildScrollView(
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               const Padding(
//                 padding: EdgeInsets.only(top: 40),
//                 child: Row(
//                   children: [
//                     Icon(Icons.arrow_back),
//                     SizedBox(
//                       width: 130,
//                     ),
//                     Text(
//                       'Business Post',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(
//                 color: Colors.black,
//               ),
//               const Center(
//                   child: Text(
//                 'Set Location',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               )),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Container(
//               //       height: 50,
//               //       width: MediaQuery.of(context).size.width,
//               //       decoration: BoxDecoration(
//               //           border: Border.all(),
//               //           borderRadius: BorderRadius.circular(20),
//               //           color: Colors.white),
//               //       child: Padding(
//               //         padding: const EdgeInsets.all(8.0),
//               //         child: Row(
//               //           mainAxisAlignment: MainAxisAlignment.start,
//               //           children: [
//               //             Icon(Icons.search),
//               //             SizedBox(
//               //               width: 30,
//               //             ),
//               //             Text('Location')
//               //           ],
//               //         ),
//               //       )),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Text('Recent'),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Container(
//               //       height: 50,
//               //       width: MediaQuery.of(context).size.width,
//               //       decoration: BoxDecoration(
//               //           border: Border.all(),
//               //           borderRadius: BorderRadius.circular(20),
//               //           color: Colors.white),
//               //       child: Row(
//               //         mainAxisAlignment: MainAxisAlignment.start,
//               //         children: [
//               //           Icon(Icons.location_on_outlined),
//               //           SizedBox(
//               //             width: 30,
//               //           ),
//               //           Text('kerala ,india')
//               //         ],
//               //       )),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Container(
//               //       height: 50,
//               //       width: MediaQuery.of(context).size.width,
//               //       decoration: BoxDecoration(
//               //           border: Border.all(),
//               //           borderRadius: BorderRadius.circular(20),
//               //           color: Colors.white),
//               //       child: Row(
//               //         mainAxisAlignment: MainAxisAlignment.start,
//               //         children: [
//               //           Icon(Icons.location_on_outlined),
//               //           SizedBox(
//               //             width: 30,
//               //           ),
//               //           Text('Manjeri,kerala')
//               //         ],
//               //       )),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Container(
//               //       height: 50,
//               //       width: MediaQuery.of(context).size.width,
//               //       decoration: BoxDecoration(
//               //           border: Border.all(),
//               //           borderRadius: BorderRadius.circular(20),
//               //           color: Colors.white),
//               //       child: Row(
//               //         mainAxisAlignment: MainAxisAlignment.start,
//               //         children: [
//               //           Icon(Icons.location_on_outlined),
//               //           SizedBox(
//               //             width: 30,
//               //           ),
//               //           Text('Eranad,Kerala')
//               //         ],
//               //       )),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Text('Choose Region'),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Container(
//               //       height: 50,
//               //       width: MediaQuery.of(context).size.width,
//               //       decoration: BoxDecoration(
//               //           border: Border.all(),
//               //           borderRadius: BorderRadius.circular(20),
//               //           color: Colors.white),
//               //       child: Padding(
//               //         padding: const EdgeInsets.all(8.0),
//               //         child: Row(
//               //           mainAxisAlignment: MainAxisAlignment.start,
//               //           children: [
//               //             Text('Kerala'),
//               //             Spacer(),
//               //             Icon(Icons.arrow_forward_ios)
//               //           ],
//               //         ),
//               //       )),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Container(
//               //       height: 50,
//               //       width: MediaQuery.of(context).size.width,
//               //       decoration: BoxDecoration(
//               //           border: Border.all(),
//               //           borderRadius: BorderRadius.circular(20),
//               //           color: Colors.white),
//               //       child: Padding(
//               //         padding: const EdgeInsets.all(8.0),
//               //         child: Row(
//               //           mainAxisAlignment: MainAxisAlignment.start,
//               //           children: [
//               //             Text('Andra pradesh'),
//               //             Spacer(),
//               //             Icon(Icons.arrow_forward_ios)
//               //           ],
//               //         ),
//               //       )),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Container(
//               //       height: 50,
//               //       width: MediaQuery.of(context).size.width,
//               //       decoration: BoxDecoration(
//               //           border: Border.all(),
//               //           borderRadius: BorderRadius.circular(20),
//               //           color: Colors.white),
//               //       child: Padding(
//               //         padding: const EdgeInsets.all(8.0),
//               //         child: Row(
//               //           mainAxisAlignment: MainAxisAlignment.start,
//               //           children: [
//               //             Text('Asam'),
//               //             Spacer(),
//               //             Icon(Icons.arrow_forward_ios)
//               //           ],
//               //         ),
//               //       )),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Container(
//               //       height: 50,
//               //       width: MediaQuery.of(context).size.width,
//               //       decoration: BoxDecoration(
//               //           border: Border.all(),
//               //           borderRadius: BorderRadius.circular(20),
//               //           color: Colors.white),
//               //       child: Padding(
//               //         padding: const EdgeInsets.all(8.0),
//               //         child: Row(
//               //           mainAxisAlignment: MainAxisAlignment.start,
//               //           children: [
//               //             Text('Bihar'),
//               //             Spacer(),
//               //             Icon(Icons.arrow_forward_ios)
//               //           ],
//               //         ),
//               //       )),
//               // ),
//               // SizedBox(
//               //   height: 10,
//               // ),
//               // Center(
//               //   // // child: InkWell(
//               //   // //   onTap: () {
//               //   // //     Navigator.push(context,
//               //   // //         MaterialPageRoute(builder: (context) => Bizpost3()));
//               //   // //   },
//               //   // child: GestureDetector(
//               //   //   onTap: () {
//               //   //     Navigator.push(context,
//               //   //         MaterialPageRoute(builder: (context) => Bizpost3()));
//               //   //   },
//               //   //   child: Container(
//               //   //     height: 40,
//               //   //     width: 100,
//               //   //     decoration: BoxDecoration(
//               //   //         borderRadius: BorderRadius.circular(10),
//               //   //         color: Colors.teal),
//               //   //     child: TextButton(
//               //   //         onPressed: () {},
//               //   //         child: Text(
//               //   //           'Next',
//               //   //           style: TextStyle(
//               //   //               color: Colors.black, fontWeight: FontWeight.bold),
//               //   //         )),
//               //   //   ),
//               //   // ),
//               //   child: SizedBox(
//               //     width: 200,
//               //     child: ElevatedButton(
//               //         style: ElevatedButton.styleFrom(
//               //             backgroundColor: Colors.teal,
//               //             foregroundColor: Colors.black,
//               //             shape: RoundedRectangleBorder(
//               //                 borderRadius: BorderRadius.circular(0))),
//               //         onPressed: () {
//               //           Navigator.push(
//               //               context,
//               //               MaterialPageRoute(
//               //                   builder: (context) => Bizpost3()));
//               //         },
//               //         child: Text(
//               //           'Next',
//               //         )),
//               //   ),
//               // ),

//               SizedBox(
//                 height: Helper.H(context) * .050,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: Helper.W(context) * .9,
//                     height: Helper.H(context) * .250,
//                     child: TextFormField(
//                       controller: helper.location,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                       ),
//                       onSaved: (newValue) {},
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: Helper.H(context) * .050,
//               ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => Bizpost3(
//                                     type: tyep,
//                                   )));
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       width: Helper.W(context) * .6,
//                       height: Helper.H(context) * .060,
//                       decoration: BoxDecoration(
//                         border: Border.all(),
//                       ),
//                       child: const Text('ADD LOCATION'),
//                     ),
//                   ),
//                 ],
//               )
//             ]),
//           )),
//     );
//   }
// }
