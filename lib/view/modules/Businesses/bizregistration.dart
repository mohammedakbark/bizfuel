import 'dart:developer';

import 'package:bizfuel/view/widgets/snackbars.dart';
import 'package:bizfuel/viewmodel/auth.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Bizregistration extends StatefulWidget {
  const Bizregistration({super.key});

  @override
  State<Bizregistration> createState() => _BizregistrationState();
}

class _BizregistrationState extends State<Bizregistration> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController phnocontroller = TextEditingController();
  TextEditingController businessnamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  bool ischecked = false;

  bool _obscureConfirmPassword = false;
  bool _obscurePassword = false;

  // void postData() async {
  //   if (!ischecked) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please agree to the terms and conditions')),
  //     );
  //     return;
  //   }

  //   if (passwordcontroller.text != confirmpasswordcontroller.text) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Passwords do not match')),
  //     );
  //     return;
  //   }

  //     await FirebaseFirestore.instance.collection('business').add({
  //       'email': emailcontroller.text,
  //       'phone': phnocontroller.text,
  //       'name': businessnamecontroller.text,
  //        'password': passwordcontroller.text,
  //       'status': '0',
  //     });

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Registration successful')),
  //     );

  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const Login()),
  //     );
  //   }

  @override
  Widget build(BuildContext context) {
    // final firehelper = Provider.of<FirebaseHelper>(context, listen: false);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  "Business Account  \n     Registration",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Consumer<FirebaseHelper>(
                            builder: (context, helper, child) {
                              return Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 4, color: Colors.grey),
                                ),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: helper.url == null
                                          ? const AssetImage("images/users.png")
                                              as ImageProvider
                                          : NetworkImage(
                                              helper.url.toString(),
                                            ),
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 4, color: Colors.grey),
                                  ),
                                  child: IconButton(
                                    onPressed: () async {
                                      await helper.pickimage();

                                      log(helper.url.toString());
                                    },
                                    icon: const Icon(Icons.camera_alt_outlined),
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              children: [
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: emailcontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "required field";
                                    }
                                    if (!value.contains('@gmail.com')) {
                                      return "Email must be a valid email address";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    filled: true,
                                    hintText: "E-mail",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10)
                                  ],
                                  controller: phnocontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "required field";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    helperMaxLines: 10,
                                    filled: true,
                                    hintText: "Phone Number",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  controller: businessnamecontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "required field";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    filled: true,
                                    hintText: "Business Name",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  controller: passwordcontroller,
                                  obscureText: _obscurePassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "required field";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: "Password",
                                    fillColor: Colors.white,
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  controller: confirmpasswordcontroller,
                                  obscureText: _obscureConfirmPassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "required field";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: "Confirm password",
                                    fillColor: Colors.white,
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscureConfirmPassword =
                                              !_obscureConfirmPassword;
                                        });
                                      },
                                      icon: Icon(
                                        _obscureConfirmPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 60),
                                      child: Text(
                                        "Agree With Terms & Conditions  ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Checkbox(
                                      fillColor: MaterialStateProperty.all(
                                          Colors.white),
                                      checkColor: Colors.black,
                                      value: ischecked,
                                      onChanged: (value) {
                                        setState(() {
                                          ischecked = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25),
                                SizedBox(
                                    width: 140,
                                    height: 50,
                                    child: Consumer2<AuthControoler,
                                        FirebaseHelper>(
                                      builder: (context, authprov, firehelper,
                                          child) {
                                        return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    233, 12, 12, 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (_formkey.currentState!
                                                .validate()) {
                                              if (firehelper.url == null) {
                                                CSnackbar.showErrorToast(
                                                    context,
                                                    "Image not picked");
                                              } else {
                                                authprov
                                                    .businessRegistration(
                                                  emailcontroller.text,
                                                  passwordcontroller.text,
                                                  context,
                                                  businessnamecontroller.text,
                                                  firehelper.url,
                                                  phnocontroller.text,
                                                )
                                                    .then((value) {
                                                  emailcontroller.clear();
                                                  passwordcontroller.clear();
                                                  businessnamecontroller
                                                      .clear();
                                                  firehelper.clearUrl();
                                                  phnocontroller.clear();
                                                });
                                              }
                                            }
                                          },
                                          child: const Text(
                                            "Submit",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      },
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
