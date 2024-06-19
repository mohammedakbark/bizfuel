import 'package:bizfuel/view/login/loginsuccesfully.dart';
import 'package:flutter/material.dart';

class Varify extends StatefulWidget {
  @override
  _VarifyState createState() => _VarifyState();
}

class _VarifyState extends State<Varify> {
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
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  "bizfuel",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 230),
                child: Text(
                  'Verification',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(right: 120),
                child: Text(
                  'Enter the verification code:',
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 4; i++) buildPinCodeTextField(),
                ],
              ),
              const SizedBox(height: 150),
              SizedBox(
                height: 50,
                width: 170,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Change()));
                    // Handle verification logic here
                  },
                  style: ElevatedButton.styleFrom(
                      // primary: Colors.black, // Background color
                      // onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)) // Text color
                      ),
                  child: const Text(
                    'VERIFY',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              const SizedBox(
                height: 170,
              ),
              const Text("Bizfuel © 2024")
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPinCodeTextField() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 60,
        height: 60,
        child: TextField(
          keyboardType: TextInputType.number,
          obscureText: true,
          textAlign: TextAlign.center,
          maxLength: 1,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            counterText: "",
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
