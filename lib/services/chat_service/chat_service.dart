import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rafiq_app/models/message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String reciverId, massage) async {
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentUserID,
        senderEmail: currentUserEmail,
        receiverId: reciverId,
        message: massage,
        timeStamp: timestamp);

    List<String> ids = [currentUserID, reciverId];
    ids.sort(); //make sure the chatroom id is the sane for any 2 people
    String chatRoomId = ids.join('_');
    print("Chat Room ID in sendMessage: $chatRoomId");
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot>getMessages(String userID,String otherUserID){
    List<String> ids = [userID, otherUserID];
    ids.sort(); //make sure the chatroom id is the sane for any 2 people
    String chatRoomId = ids.join('_');
    print("Chat Room ID in getMessages: $chatRoomId");
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timeStamp",
        descending: false)
        .snapshots();

  }
}
