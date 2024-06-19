import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/modules/Businesses/bizhomepage.dart';
import 'package:bizfuel/view/modules/Businesses/bizregistration.dart';
import 'package:bizfuel/view/modules/Businesses/buzbottomsheet.dart';
import 'package:bizfuel/view/login/home1.dart';
import 'package:bizfuel/view/login/reset.dart';
import 'package:bizfuel/view/login/tutorial.dart';
import 'package:bizfuel/viewmodel/auth.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/background.jpg"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  const Text(
                    "bizfuel",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          filled: true,
                          hintText: "Mobile number or email id",
                          fillColor: Color.fromARGB(229, 255, 255, 255),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextFormField(
                        controller: password,
                        decoration: const InputDecoration(
                            filled: true,
                            hintText: "Password",
                            fillColor: Color.fromARGB(229, 255, 255, 255),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 600,
                    height: 55,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Consumer<AuthControoler>(
                          builder: (context, helper, child) {
                            return ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.black)),
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  helper.signin(
                                      email.text, password.text, context);
                                }
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Reset()));
                      },
                      child: const Text(
                        "Forgotten password?",
                        style: TextStyle(color: Color.fromARGB(239, 0, 0, 0)),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Expanded(
                          child: Divider(
                        indent: 10,
                        endIndent: 10,
                        color: Colors.black,
                        thickness: 1,
                        height: 3,
                      )),
                      Text("OR"),
                      Expanded(
                          child: Divider(
                        indent: 10,
                        endIndent: 10,
                        color: Colors.black,
                        thickness: 1,
                        height: 3,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 55,
                    width: 370,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.white)),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Homeone()));
                          },
                          child: const Text(
                            "Create new account",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.black)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Tutorial()));
                        },
                        child: const Text(
                          "TUTORIAL",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const Text("Bizfuel © 2024")
                ],
              ),
            ),
          )),
    );
  }
}
