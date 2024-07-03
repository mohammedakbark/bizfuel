import 'package:bizfuel/model/feeback_model.dart';
import 'package:bizfuel/view/widgets/snackbars.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FeebackPage extends StatelessWidget {
  String module;
  FeebackPage({super.key, required this.module});
  final feeback = TextEditingController();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                "Feedback",
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: feeback,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Feedback & Review",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 40, 135, 125),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0))),
                onPressed: () {
                  if (feeback.text.isNotEmpty) {
                    FirebaseHelper().addFeddback(FeedbackModel(
                      feedbackMessage: feeback.text,
                      fromModule: module,
                    ));
                    feeback.clear();
                    CSnackbar.showSuccessToast(context, "Feedback Successful");
                  }
                },
                child: const Text('Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
