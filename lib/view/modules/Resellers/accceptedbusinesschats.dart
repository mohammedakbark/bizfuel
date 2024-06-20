import 'package:bizfuel/model/businessregistration.dart';
import 'package:bizfuel/model/messagemodel.dart';
import 'package:bizfuel/utils/string.dart';
import 'package:bizfuel/view/widgets/chat_page.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcceptBusinessChats extends StatefulWidget {
  const AcceptBusinessChats({Key? key}) : super(key: key);

  @override
  State<AcceptBusinessChats> createState() => _AcceptBusinessChatsState();
}

class _AcceptBusinessChatsState extends State<AcceptBusinessChats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Consumer<FirebaseHelper>(builder: (context, searcher, child) {
            // searcher.businessSearchResult = [];
            return Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Accepted Business Chats",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    onTap: () {
                      searcher.getBusinessForSearch();
                    },
                    onChanged: (value) {
                      searcher.searchABusiness(searcher.businessList, value);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Find Business",
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Expanded(child: Consumer<FirebaseHelper>(
                  builder: (context, helper, child) {
                    return FutureBuilder(
                      future:
                          helper.getChatpossibleUsers("BusinessRegistration"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        List<BusinesRegistrationModel> list = [];
                        if (searcher.businessList.isNotEmpty) {
                          list = searcher.businessSearchResult;
                        } else {
                          list = helper.listOfUsersForChat
                              .map((e) => BusinesRegistrationModel.fromjsone(
                                  e.data() as Map<String, dynamic>))
                              .toList();
                        }

                        return list.isEmpty
                            ? const Center(
                                child: Text("No Chat Found"),
                              )
                            : ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ChatPage(
                                                      contactNumber: list[index]
                                                          .phonenumber,
                                                      isThisBusinessProfile:
                                                          true,
                                                      anotherUserId:
                                                          list[index].id!,
                                                      anotherUserProfile:
                                                          list[index].image,
                                                      anotherUsername:
                                                          list[index]
                                                              .businessName,
                                                    )));
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 2,
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(list[index].image),
                                            radius: 25,
                                          ),
                                          title: Text(list[index].businessName),
                                          // subtitle: Text(data[index]['message']!),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Text(
                                              //   data[index]['date']!,
                                              //   style: TextStyle(
                                              //     color: Colors.grey,
                                              //     fontSize: 12,
                                              //   ),
                                              // ),
                                              const SizedBox(width: 8),
                                              PopupMenuButton(
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    child: ListTile(
                                                      leading: const Icon(
                                                          Icons.delete),
                                                      title:
                                                          const Text('Delete'),
                                                      onTap: () {
                                                        // Handle delete action
                                                        // setState(() {
                                                        //   data.removeAt(index);
                                                        // });
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                      },
                    );
                  },
                )),
              ],
            );
          }),
        ),
      ),
    );
  }

  TextEditingController controller = TextEditingController();
  message(MessageModel messageModel) {
    bool isme = messageModel.senderID == auth.currentUser!.uid;
    return Align(
      alignment: isme ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: isme ? Colors.grey : Colors.blue,
          borderRadius: isme
              ? const BorderRadius.horizontal(left: Radius.elliptical(20, 10))
              : const BorderRadius.horizontal(right: Radius.elliptical(20, 10)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(messageModel.message),
        ),
      ),
    );
  }
}
