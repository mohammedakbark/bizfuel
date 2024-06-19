import 'package:bizfuel/view/login/login.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 460, top: 7),
              child: Row(
                children: [
                  Icon(Icons.info),
                  Text('Help'),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              "images/shakehand.png",
              scale: .8,
            ),
            // const Image(image: AssetImage("images/shakehand.png", ) ),
            const SizedBox(height: 15),
            const Text(
              "welcome to BIZFUEL",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "The trusted community of",
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              "businesses and resellers",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 150,
            ),
            SizedBox(
              width: 175,
              height: 70,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(233, 12, 12, 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 25,
            ),
            Text("Bizfuel © 2024")
          ],
        ),
      ),
    ));
  }
}
