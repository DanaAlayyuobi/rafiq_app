import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/story.dart';

class SuccessStoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addNewStory(
      String title,
      String description,
      String urlPhoto,

      ) async {
    try {
      // Get the current user's ID
      final userId = _auth.currentUser?.uid;

      if (userId == null) {
        throw Exception("User is not authenticated");
      }

      // Create a unique document ID using userID and pet name
      final StoryID = "${userId}_$title";

      // Create a new pet object
      final newStory = Story(
         title,
        description,
        urlPhoto,
      );

      // Save the pet data in Firestore under the specified document ID
      await _firestore.collection('stories').doc(StoryID).set(newStory.toMap());
      print("Story added successfully with ID: $newStory");
    } catch (e) {
      print("Error adding Story: $e");
      throw Exception("Failed to add Story");
    }
  }

  Future<List<Story>> fetchStory() async {
    try {
      final querySnapshot = await _firestore.collection('stories').get();
      return querySnapshot.docs.map((doc) {
        return Story.fromMap(doc.data());
      }).toList();
    } catch (e) {
      print("Error fetching Stories: $e");
      throw Exception("Failed to fetch Stories");
    }
  }
}
