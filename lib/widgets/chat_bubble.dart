import 'package:flutter/material.dart';
import 'package:scholar_chat/models/messageModel.dart';

import '../constants.dart';

class chatBubble extends StatelessWidget {
  chatBubble({Key? key, required this.msg}) : super(key: key);
  final messageModel msg;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        width: 150,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          msg.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class chatBubbleForFriend extends StatelessWidget {
  chatBubbleForFriend({Key? key, required this.msg}) : super(key: key);
  final messageModel msg;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        width: 150,
        decoration: BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(
          msg.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
