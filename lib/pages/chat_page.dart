import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/messageModel.dart';

import '../widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key, required this.email}) : super(key: key);
  final String email;

  CollectionReference messages =
      FirebaseFirestore.instance.collection("Messages");

  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<messageModel> msgList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              msgList.add(messageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: kPrimaryColor,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        kLogo,
                        height: 50,
                      ),
                      Text("Chat"),
                    ],
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          reverse: true,
                          controller: _controller,
                          itemCount: msgList.length,
                          itemBuilder: (context, index) {
                            return msgList[index].id == email
                                ? chatBubble(msg: msgList[index])
                                : chatBubbleForFriend(msg: msgList[index]);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        controller: controller,
                        onSubmitted: (data) {
                          if (data.trim().isNotEmpty) {
                            messages.add({
                              'message': data,
                              'createdAt': DateTime.now(),
                              'id': email
                            });
                            controller.clear();
                            _controller.animateTo(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.send),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(16))),
                      ),
                    ),
                  ],
                ));
          } else {
            return Text("Loading ...");
          }
        });
  }
}
