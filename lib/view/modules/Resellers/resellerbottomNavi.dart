import 'package:bizfuel/view/modules/Resellers/accceptedbusinesschats.dart';
import 'package:bizfuel/view/modules/Resellers/resellerhomepage.dart';
import 'package:bizfuel/view/modules/Resellers/resellerprofile.dart';
import 'package:bizfuel/view/modules/Resellers/viewreqbusiness.dart';
import 'package:flutter/material.dart';

class ResellerbottomNavi extends StatefulWidget {
  const ResellerbottomNavi({super.key});

  @override
  State<ResellerbottomNavi> createState() => _ResellerbottomNaviState();
}

class _ResellerbottomNaviState extends State<ResellerbottomNavi> {
  List<Widget> pages = [
    Resellerhomepage(),
    AcceptBusinessChats(),
    ViewReqBusiness(),
    ResellerProfile()
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
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_add_alt,
              // color: Colors.black,
            ),
            label: 'Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.circle,
              // color: Colors.black,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
