
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafiq_app/services/auth_services/auth_service.dart';
import 'package:rafiq_app/services/chat_service/chat_service.dart';
import 'package:rafiq_app/widget/chat_bubble.dart';
import 'package:rafiq_app/widget/text_feild_widget.dart';

class ChatScreen extends StatefulWidget {
  final String reciveEmail;
  final String reciverId;

  ChatScreen({super.key, required this.reciveEmail, required this.reciverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  FocusNode myFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(Duration(milliseconds: 500), () => _scrollDown());
      }
    });
    Future.delayed(Duration(milliseconds: 500), () => _scrollDown());
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.reciverId, _messageController.text);
      _messageController.clear();
    }
    _scrollDown();
  }

  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  void _scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.reciveEmail,style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.reciverId, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }
          if (!snapshot.hasData) {
            return const Text("No messages available.");
          }

          return ListView(
              controller: _scrollController,
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageItem(doc))
                  .toList());
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    print("_buildMessageItem inside");
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;
    return Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
            ],
          ),
        ));
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Row(
        children: [
          Expanded(
              child: TextFeildWidget(
                  focusNode: myFocusNode,
                  isObscure: false,
                  hitText: "type a message...",
                  TextController: _messageController)),
          IconButton(
              onPressed: _sendMessage,
              icon:  Icon(
                Icons.send_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              ))
        ],
      ),
    );
  }
}
