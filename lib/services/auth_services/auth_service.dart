import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  String? get loggedUid => _auth.currentUser?.uid;


  // signIn
  Future<UserCredential> signInWithEmailPassword(String status,
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'status':status ,
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));  // Ensure the new field is added
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // signUp
  Future<UserCredential> signUpWithEmailPassword(String status,
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'status': status,
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));  // Ensure the new field is added
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }
  Future<String?> getEmailByUserId(String userId) async {
    try {
      // Fetch the document from Firestore
      DocumentSnapshot userDoc =
      await _firestore.collection('Users').doc(userId).get();

      if (userDoc.exists) {
        // Return the email field if it exists
        return userDoc['email'];
      } else {
        print("No user found with ID: $userId");
        return null;
      }
    } catch (e) {
      print("Error retrieving email: $e");
      return null;
    }
  }


}
