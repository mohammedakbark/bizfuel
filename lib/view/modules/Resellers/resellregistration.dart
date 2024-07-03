import 'dart:developer';

import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/modules/Resellers/resellerhomepage.dart';
import 'package:bizfuel/view/widgets/snackbars.dart';
import 'package:bizfuel/viewmodel/auth.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Resellregistration extends StatefulWidget {
  const Resellregistration({super.key});

  @override
  State<Resellregistration> createState() => _ResellregistrationState();
}

class _ResellregistrationState extends State<Resellregistration> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _agreeToTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void postData() async {
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please agree to the terms and conditions')),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('resellers').add({
      'email': emailController.text,
      'phone': phoneController.text,
      'name': nameController.text,
      'qualification': qualificationController.text,
      'password': passwordController.text,
      'status': '0',
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration successful')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Resellerhomepage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                    "Reseller Account  \n     Registration",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Consumer<FirebaseHelper>(
                            builder: (context, helper, child) {
                              return Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: helper.url == null
                                        ? AssetImage("images/users.png")
                                            as ImageProvider
                                        : NetworkImage(
                                            helper.url.toString(),
                                          ),
                                  ),
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 4, color: Colors.grey),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    helper.pickimage();
                                  },
                                  icon: const Icon(Icons.camera_alt_outlined),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    hintText: "E-mail",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email or phone number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: phoneController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10 )
                                  ],
                                  decoration: const InputDecoration(
                                    helperMaxLines: 10,
                                    filled: true,
                                    hintText: "Contact Number",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email or phone number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    hintText: "Name",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  controller: qualificationController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    hintText: "Qualification",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your qualification';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: _obscurePassword,
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  controller: confirmPasswordController,
                                  obscureText: _obscureConfirmPassword,
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm your password';
                                    }
                                    return null;
                                  },
                                ),
                                // const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Agree With Terms & Conditions",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Checkbox(
                                      value: _agreeToTerms,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _agreeToTerms = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                    width: 140,
                                    height: 50,
                                    child: Consumer2<AuthControoler,
                                        FirebaseHelper>(
                                      builder: (context, authcontroler, helper,
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
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                _agreeToTerms) {
                                              if (helper.url == null) {
                                                CSnackbar.showErrorToast(
                                                    context,
                                                    "PICK PROFILE IMAGE");
                                              } else {
                                                log("message");
                                                authcontroler
                                                    .userRegitration(
                                                  emailController.text,
                                                  passwordController.text,
                                                  context,
                                                  helper.url,
                                                  phoneController.text,
                                                  nameController.text,
                                                  qualificationController.text,
                                                )
                                                    .then((value) {
                                                  clear();
                                                  helper.clearUrl();
                                                });
                                              }
                                            } else {
                                              CSnackbar.showErrorToast(context,
                                                  "Agree term and conditions");
                                            }
                                          },
                                          child: const Text(
                                            "Submit",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  clear() {
    nameController.clear();
    emailController.clear();
    qualificationController.clear();
    passwordController.clear();
  }
}
