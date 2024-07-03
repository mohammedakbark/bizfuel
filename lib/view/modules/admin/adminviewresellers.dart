import 'package:bizfuel/view/modules/admin/widget.dart';
import 'package:bizfuel/view/widgets/snackbars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminViewResellers extends StatefulWidget {
  const AdminViewResellers({super.key});

  @override
  State<AdminViewResellers> createState() => _AdminViewResellersState();
}

class _AdminViewResellersState extends State<AdminViewResellers> {
  late Stream<QuerySnapshot> _sellerStream;

  @override
  void initState() {
    super.initState();
    // Initialize the stream to display all resellers initially
    _sellerStream =
        FirebaseFirestore.instance.collection('Usergegitration').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  topAppBar(context)
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _sellerStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final data = snapshot.requireData;

                    return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        var reseller = data.docs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        NetworkImage(reseller['image'] ?? ''),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 17.0, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(reseller['name'] ?? 'No name'),
                                      Text(reseller['email'] ?? 'No type'),
                                      // Text(reseller['qualification '] ??
                                      //     'No room'),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: SizedBox(
                                    width: 120,
                                    height: 40,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 217, 32, 32),
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                      ),
                                      onPressed: () {
                                        _removeReseller(reseller.id);
                                      },
                                      child: Text("Remove"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _removeReseller(String id) {
    FirebaseFirestore.instance
        .collection('Usergegitration')
        .doc(id)
        .delete()
        .then((_) {
      CSnackbar.showErrorToast(context, "Reseller removed successfully");
    }).catchError((error) {
      CSnackbar.showErrorToast(context, "Failed to remove reseller: $error");
    });
  }
}
