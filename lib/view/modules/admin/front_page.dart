import 'package:bizfuel/view/modules/admin/loginpage.dart';
import 'package:flutter/material.dart';

class AdminFrontPage extends StatefulWidget {
  const AdminFrontPage({super.key});

  @override
  State<AdminFrontPage> createState() => _AdminFrontPageState();
}

class _AdminFrontPageState extends State<AdminFrontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child:
          // Image.asset("assets/pexels-image-hunter-281453274-13012295.jpg"),

          Padding(
        padding: const EdgeInsets.only(top: 280),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lets\n Start",
              style: TextStyle(fontSize: 48, fontFamily: 'Cursive'),
            ),
            SizedBox(
              height: 100,
            ),
            SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor:
                            const Color.fromARGB(255, 224, 224, 224),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminLoginPage()));
                    },
                    child: Text("Login")))
          ],
        ),
      ),
    ));
  }
}
