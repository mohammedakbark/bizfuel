import 'package:bizfuel/view/login/varification.dart';
import 'package:bizfuel/view/widgets/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Reset extends StatefulWidget {
  const Reset({super.key});

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  final email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                'bizfuel',
                style: TextStyle(fontSize: 35),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  right: 220,
                  top: 35,
                ),
                child: Text(
                  "Reset password",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Image.asset(
                "images/password.png",
                scale: 1.5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Email:',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                        controller: email,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)))),
                    SizedBox(
                      height: 115,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 170,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(233, 12, 12, 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      if (email.text.isNotEmpty) {
                        FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email.text)
                            .then((value) {
                          CSnackbar.showSuccessToast(context,
                              "Password reset link shared to ${email.text}");
                          Navigator.of(context).pop();
                        }).catchError((error) {
                          CSnackbar.showErrorToast(
                              context, "Error while sending password reset");
                        });
                      }

                      //   Navigator.push(context,
                      //       MaterialPageRoute(builder: (context) => Varify()));
                    },
                    child: const Text(
                      "SEND",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                height: 150,
              ),
              Text("Bizfuel © 2024")
            ],
          ),
        ),
      ),
    );
  }
}
