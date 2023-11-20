import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.msg}) : super(key: key);

  final Message msg;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        padding: EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(26),
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
        ),
        child: Text(
          msg.message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForOther extends StatelessWidget {
  const ChatBubbleForOther({Key? key, required this.msg}) : super(key: key);

  final Message msg;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        // alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        padding: EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
            //bottomRight: Radius.circular(26),
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
            bottomLeft: Radius.circular(26),
          ),
        ),
        child: Text(
          msg.message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
