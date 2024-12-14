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
}
