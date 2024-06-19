import 'package:flutter/material.dart';

class ResellerUsers extends StatefulWidget {
  const ResellerUsers({super.key});

  @override
  State<ResellerUsers> createState() => _ResellerUsersState();
}

class _ResellerUsersState extends State<ResellerUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover)),)
    );
  }
}