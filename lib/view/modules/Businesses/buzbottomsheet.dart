import 'package:bizfuel/view/modules/Businesses/Myads1.dart';
import 'package:bizfuel/view/modules/Businesses/account.dart';
import 'package:bizfuel/view/modules/Businesses/bizhomepage.dart';
import 'package:bizfuel/view/modules/Businesses/businesstype.dart';
import 'package:bizfuel/view/modules/Businesses/inbox.dart';
import 'package:flutter/material.dart';

class BizbottomNavi extends StatefulWidget {
  const BizbottomNavi({super.key});

  @override
  State<BizbottomNavi> createState() => _BizbottomNaviState();
}

class _BizbottomNaviState extends State<BizbottomNavi> {
  List<Widget> pages = [
    const Bizhomepge(),
    const Inbox(),
    const Businesstype(),
    const Myads1(),
    const Account()
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.teal),
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              // color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              // color: Colors.black,
            ),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              // color: Colors.black,
            ),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              // color: Colors.black,
            ),
            label: 'Ads',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
              // color: Colors.black,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
