import 'dart:developer';

import 'package:bizfuel/model/businessregistration.dart';
import 'package:bizfuel/model/businesstypemodel.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/modules/Businesses/bizpost2.dart';
import 'package:bizfuel/view/widgets/snackbars.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditMyAds extends StatefulWidget {
  final BusinesPost post;
  const EditMyAds({super.key, required this.post});

  @override
  State<EditMyAds> createState() => _EditMyAdsState();
}

class _EditMyAdsState extends State<EditMyAds> {
  @override
  Widget build(BuildContext context) {
    // final helper = Provider.of<FirebaseHelper>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Consumer<FirebaseHelper>(builder: (context, helper, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(
                            width: 80,
                          ),
                          Text(
                            'Business Post',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    FutureBuilder(
                        future: FirebaseHelper().getSelectedBusinesprofile(
                            FirebaseAuth.instance.currentUser!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: SizedBox(),
                            );
                          }
                          BusinesRegistrationModel model =
                              BusinesRegistrationModel.fromjsone(snapshot.data!
                                  .data() as Map<String, dynamic>);
                          helper.contactnumber.text = model.phonenumber;
                          helper.businessname.text = model.businessName;
                          return Column(
                            children: [
                              Center(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Field is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: helper.contactnumber,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10)
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'Phone Number',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Field is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: helper.businessname,
                                  decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'BusinessName',
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field is required";
                          } else {
                            return null;
                          }
                        },
                        controller: helper.location,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Location',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is required";
                        } else {
                          return null;
                        }
                      },
                      controller: helper.keyfeature,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'key features to your item',
                      ),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(child: Consumer<FirebaseHelper>(
                      builder: (context, helper, child) {
                        return GestureDetector(
                          onTap: () {
                            helper.pickMultipleImage();
                            // helper.pickListImage();
                            // log(helper.listImage.toString());
                            // helper.pickimage();
                          },
                          child: Container(
                            height: 120,
                            // width: 320,
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
                              border: Border.all(),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add)),
                                const Text("Add some photos"),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<FirebaseHelper>(
                        builder: (context, controller, child) {
                      return controller.listOfImages.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: 200,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.listOfImages.length,
                                itemBuilder: (context, index) =>
                                    Image.file(controller.listOfImages[index]),
                              ),
                            );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field is required";
                          } else {
                            return null;
                          }
                        },
                        controller: helper.discription,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Description',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Center(
                        child: InkWell(
                      onTap: () {
                        if (helper.isLoading == false) {
                          if (helper.listOfImages.isNotEmpty) {
                            helper
                                .storeMultipleImages(helper.listOfImages)
                                .then((value) {
                              helper
                                  .editBusinessPost(
                                      widget.post.id,
                                      BusinesPost(
                                        location: helper.location.text.isEmpty
                                            ? widget.post.location
                                            : helper.location.text,
                                        businesname:
                                            helper.businessname.text.isEmpty
                                                ? widget.post.businesname
                                                : helper.businessname.text,
                                        keyfeature:
                                            helper.keyfeature.text.isEmpty
                                                ? widget.post.keyfeature
                                                : helper.keyfeature.text,
                                        images: helper.listOfImageUrl.isEmpty
                                            ? widget.post.images
                                            : helper.listOfImageUrl,
                                        description:
                                            helper.discription.text.isEmpty
                                                ? widget.post.description
                                                : helper.discription.text,
                                        type: widget.post.type,
                                        phonenumber:
                                            helper.contactnumber.text.isEmpty
                                                ? widget.post.phonenumber
                                                : helper.contactnumber.text,
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid,
                                      ))
                                  .then((value) {
                                Navigator.of(context).pop();
                                helper.clear();
                                CSnackbar.showSuccessToast(
                                    context, "Post is scuccessfully updated");
                              });
                            });
                          } else {
                            helper
                                .editBusinessPost(
                                    widget.post.id,
                                    BusinesPost(
                                      location: helper.location.text.isEmpty
                                          ? widget.post.location
                                          : helper.location.text,
                                      businesname:
                                          helper.businessname.text.isEmpty
                                              ? widget.post.businesname
                                              : helper.businessname.text,
                                      keyfeature: helper.keyfeature.text.isEmpty
                                          ? widget.post.keyfeature
                                          : helper.keyfeature.text,
                                      images: helper.listOfImageUrl.isEmpty
                                          ? widget.post.images
                                          : helper.listOfImageUrl,
                                      description:
                                          helper.discription.text.isEmpty
                                              ? widget.post.description
                                              : helper.discription.text,
                                      type: widget.post.type,
                                      phonenumber:
                                          helper.contactnumber.text.isEmpty
                                              ? widget.post.phonenumber
                                              : helper.contactnumber.text,
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid,
                                    ))
                                .then((value) {
                              Navigator.of(context).pop();
                              helper.clear();
                              CSnackbar.showSuccessToast(
                                  context, "Post is scuccessfully updated");
                            });
                          }
                        }

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => Bizpost2(
                        //       tyep: widget.type,
                        //     ),
                        //   ),
                        // );
                      },
                      child: helper.isLoading
                          ? Helper.showIndicator()
                          : Container(
                              height: 30,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 2, 124, 65),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: const Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                    )),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
