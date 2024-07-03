import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bizfuel/model/messagemodel.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/chat.dart';
import 'package:bizfuel/view/widgets/paymnet.dart';
import 'package:bizfuel/view/widgets/voice_message.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatefulWidget {
  bool isThisBusinessProfile;
  String anotherUserId;
  String anotherUsername;
  String anotherUserProfile;
  String contactNumber;

  ChatPage(
      {super.key,
      required this.contactNumber,
      required this.isThisBusinessProfile,
      required this.anotherUserId,
      required this.anotherUserProfile,
      required this.anotherUsername});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  AnimationController? animationController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/background.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              FutureBuilder(
                  future: widget.isThisBusinessProfile
                      ? FirebaseHelper()
                          .getSelectedBusinesprofile(widget.anotherUserId)
                      : FirebaseHelper()
                          .getSelectedReSellerProfile(widget.anotherUserId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center();
                    }
                    if (widget.isThisBusinessProfile == true) {
                      return appbar(snapshot.data!.data()!["image"],
                          snapshot.data!.data()!["businesname"]);
                    } else {
                      return appbar(snapshot.data!.data()!["image"],
                          snapshot.data!.data()!["name"]);
                    }
                  }),
              const Divider(
                color: Colors.black,
              ),
              isImageIsLoading ? Helper.showIndicator() : const SizedBox(),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: CommunicationController().getMessage(
                          FirebaseAuth.instance.currentUser!.uid,
                          widget.anotherUserId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text("No Messages"),
                          );
                        }
                        List<MessageModel> listOfMessages = snapshot.data!.docs
                            .map((e) => MessageModel.fromjsone(
                                e.data() as Map<String, dynamic>))
                            .toList();
                        return ListView.builder(
                            itemCount: listOfMessages.length,
                            itemBuilder: (context, index) {
                              return message(listOfMessages[index]);
                              // return message(messageModel)
                            });
                      })),
              SizedBox(
                height: Helper.H(context) * .1,
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // IconButton(
              //     onPressed: () {},
              //     icon: const Icon(
              //       Icons.add,
              //       color: Colors.black,
              //     )),
              Expanded(
                child: TextFormField(
                  controller: meesaagecontroller,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: "      Messsage",
                    filled: true,
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (meesaagecontroller.text.isNotEmpty) {
                            CommunicationController().sendmessage(
                                widget.anotherUserId,
                                meesaagecontroller.text,
                                "Text");
                            meesaagecontroller.clear();
                          }
                        },
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.black,
                        )),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        showDragHandle: true,
                        context: context,
                        builder: (context) => PaymentPage());
                  },
                  icon: const Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.black,
                  )),
              Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      log("message");
                      showModalBottomSheet(
                        // transitionAnimationController: animationController,
                        enableDrag: true,
                        context: context,
                        builder: (context) {
                          return AspectRatio(
                              aspectRatio: 2,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 5,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color: black,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(2))),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _customeButton(Icons.image, "GALLERY",
                                              () {
                                            openCamera(ImageSource.gallery)
                                                .then((value) {
                                              if (value != "") {
                                                CommunicationController()
                                                    .sendmessage(
                                                        widget.anotherUserId,
                                                        value,
                                                        "Image");
                                                setState(() {
                                                  isImageIsLoading = false;
                                                });
                                              }
                                            });
                                            // controller.pickImagesFormGallery();
                                            Navigator.of(context).pop();
                                          }),
                                          _customeButton(
                                              Icons.camera_alt, "CAMERA", () {
                                            openCamera(ImageSource.camera)
                                                .then((value) {
                                              if (value != "") {
                                                CommunicationController()
                                                    .sendmessage(
                                                        widget.anotherUserId,
                                                        value,
                                                        "Image");
                                                setState(() {
                                                  isImageIsLoading = false;
                                                });
                                              }
                                            });
                                            // controller.pickImageFromCamera();
                                            Navigator.of(context).pop();
                                          })
                                        ],
                                      ),
                                      const SizedBox()
                                    ],
                                  ),
                                ),
                              ));
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ));
              }),
              IconButton(
                  onPressed: () async {
                    if (isRecording == false) {
                      await _startRecording();
                    } else {
                      _stopRecording().then((value) {
                        if (value != "") {
                          log(value);
                          CommunicationController().sendmessage(
                              widget.anotherUserId, value, "Voice");
                        } else {
                          log("no data");
                        }
                      });
                    }
                  },
                  icon: Icon(
                    isRecording ? Icons.stop : Icons.mic_rounded,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  final meesaagecontroller = TextEditingController();

  message(MessageModel messageModel) {
    bool isMe = messageModel.senderID == FirebaseAuth.instance.currentUser!.uid;
    return Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(children: [
          if (messageModel.messageType == "Image")
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 250,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: isMe
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(0))
                        : const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(20)),
                    color: const Color.fromARGB(255, 146, 193, 202),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(messageModel.message))),
              ),
            ),
          if (messageModel.messageType == "Text")
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: isMe
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(0))
                      : const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(20)),
                  color: Colors.white),
              child: Text(messageModel.message),
            ),
          if (messageModel.messageType == "Voice")
            VoiceMessage(
              url: messageModel.message,
              anotheruid: messageModel.senderID,
            )
        ]));
  }

  appbar(String profile, name) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(profile),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
            const Text(
              " Online",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
        const Spacer(),
        // IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.camera_alt,
        //       color: Colors.black,
        //     )),
        IconButton(
            onPressed: () async {
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: widget.contactNumber,
              );
              await launchUrl(launchUri);
            },
            icon: const Icon(
              Icons.call,
              color: Colors.black,
            ))
      ],
    );
  }

  File? image;
  bool isImageIsLoading = false;
  Future<String> openCamera(ImageSource source) async {
    final chatRoomId = [
      FirebaseAuth.instance.currentUser!.uid,
      widget.anotherUserId
    ];
    chatRoomId.sort();
    final ids = chatRoomId.join('_');
    final Timestamp time = Timestamp.now();
    final storage = FirebaseStorage.instance;
    ImagePicker picker = ImagePicker();
    final pickeedFile = await picker.pickImage(source: source);
    if (pickeedFile == null) return "";

    image = File(pickeedFile.path);
    isImageIsLoading = true;
    setState(() {});
    SettableMetadata metadata = SettableMetadata(contentType: "image/jpeg");

    UploadTask uploadTask =
        storage.ref().child('Chat/$ids/$time').putFile(image!, metadata);

    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  //----------------voice
  FlutterSoundRecorder? _recorder;

  @override
  void initState() {
    _recorder = FlutterSoundRecorder();
    // TODO: implement initState
    super.initState();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _recorder!.openRecorder();
  }

  bool isRecording = false;

  Future<void> _startRecording() async {
    if (await Permission.microphone.isGranted) {
      isRecording = true;
      final Timestamp time = Timestamp.now();
      setState(() {});
      try {
        await _recorder!.startRecorder(
          toFile: 'voice_message_$time.aac',
          codec: Codec.aacADTS, // Try a different codec if necessary
          // audioSource: aud,
        );
      } catch (e) {
        log(e.toString());
      }
    } else {
      // Handle microphone permission not granted scenario
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Microphone permission is required for recording'),
        ),
      );
    }
  }

  Future<String> _stopRecording() async {
    isRecording = false;
    setState(() {});
    final chatRoomId = [
      FirebaseAuth.instance.currentUser!.uid,
      widget.anotherUserId
    ];
    chatRoomId.sort();
    final ids = chatRoomId.join('_');
    final Timestamp time = Timestamp.now();
    final storage = FirebaseStorage.instance;
    return await _recorder!.stopRecorder().then((path) async {
      if (path == null) return "";

      final storageRef = storage.ref().child('$ids/Voice Note/$time');
      await storageRef.putFile(File(path));

      return await storageRef.getDownloadURL();
      // log("========================$value========ooo===============");
    });
  }

  Widget _customeButton(IconData icon, String text, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Helper.H(context) * .12,
        width: Helper.W(context) * .4,
        decoration: BoxDecoration(
          // color: black,
          border: Border.all(color: black, width: 4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: black,
              size: 50,
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: black,
                letterSpacing: 1,
              ),
            )
          ],
        ),
      ),
    );
  }

  final black = Colors.black;
}
