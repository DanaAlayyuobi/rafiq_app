
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafiq_app/screens/chat_screens/chat_screen.dart';
import 'package:rafiq_app/services/auth_services/auth_service.dart';
import 'package:rafiq_app/services/chat_service/chat_service.dart';
import 'package:rafiq_app/widget/user_tile_widget.dart';


class MainChatScreen extends StatefulWidget {
  MainChatScreen({super.key});

  @override
  State<MainChatScreen> createState() => _HomePageState();
}

class _HomePageState extends State<MainChatScreen> with WidgetsBindingObserver {
  final ChatService _chatServices = ChatService();
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  void setStatus(String status) async {
    await _firestore
        .collection('Users')
        .doc(_firebaseAuth.currentUser?.uid)
        .update({'status': status});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setStatus('Online'); // App is in the foreground
    } else if (state == AppLifecycleState.paused) {
      setStatus('Offline'); // App is in the background
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
    stream: _chatServices.getUsersStream(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return const Text("error");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text("Loading..." ,);
      }
      return ListView(
        children: snapshot.data!
            .map<Widget>(
                (userData) => _buildUserListItem(userData, context))
            .toList(),
      );
    });
  }


  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTileWidget(
        name: userData["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  reciverId: userData["uid"],
                  reciveEmail: userData["email"],
                ),
              ));
        },
        status: userData['status'],
      );
    } else {
      return Container();
    }
  }
}
