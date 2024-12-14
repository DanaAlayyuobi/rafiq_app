import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isCurrentUser
              ? Color(0xFFFBD743)
              : Color(0x6CFFCB00)),
      padding: const EdgeInsets.all(16.0),
      margin:EdgeInsets.symmetric(vertical: 2.5,horizontal: 25) ,
      child: Text(
        message,
      ),
    );
  }
}
