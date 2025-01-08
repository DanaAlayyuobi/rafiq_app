import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rafiq_app/models/adoption_pet_info.dart';

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
        'status': status,
        'uid': userCredential.user!.uid,
        'email': email,
        'favorites': [], // Initialize with an empty list
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
        'favorites': [], // Initialize with an empty list
      }, SetOptions(merge: true));  // Ensure the new field is added
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // Get Email by User ID
  Future<String?> getEmailByUserId(String userId) async {
    try {
      DocumentSnapshot userDoc =
      await _firestore.collection('Users').doc(userId).get();

      if (userDoc.exists) {
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

  // Add Item to Favorites
  Future<void> addToFavorites(String userId, AdoptionPetInfo petInfo) async {
    try {
      await _firestore.collection('Users').doc(userId).update({
        'favorites': FieldValue.arrayUnion([petInfo.petID]),
      });
    } catch (e) {
      print("Error adding to favorites: $e");
    }
  }

  // Remove Item from Favorites
  Future<void> removeFromFavorites(String userId, AdoptionPetInfo petInfo) async {
    try {
      await _firestore.collection('Users').doc(userId).update({
        'favorites': FieldValue.arrayRemove([petInfo.petID]),
      });
    } catch (e) {
      print("Error removing from favorites: $e");
    }
  }

  // Get Favorites List
  Future<List<String>> getFavorites(String userId) async {
    try {
      DocumentSnapshot userDoc =
      await _firestore.collection('Users').doc(userId).get();

      if (userDoc.exists) {
        List<String> favorites = List<String>.from(userDoc['favorites']);
        return favorites;
      } else {
        print("No favorites found for user with ID: $userId");
        return [];
      }
    } catch (e) {
      print("Error retrieving favorites: $e");
      return [];
    }
  }
}
