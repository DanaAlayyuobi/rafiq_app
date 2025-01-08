import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/adoption_pet_info.dart';

class PetListService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addNewPet(
    String name,
    String type,
    double age,
    String gender,
    String location,
    String description,
    String petURLPhoto,
    double friendlinessRate,
    double trainablityRate,
    double healthRate,
    double adaptibilityRate,
  ) async {
    try {
      // Get the current user's ID
      final userId = _auth.currentUser?.uid;

      if (userId == null) {
        throw Exception("User is not authenticated");
      }

      // Create a unique document ID using userID and pet name
      final PetID = "${userId}_$name";

      // Create a new pet object
      final newPet = AdoptionPetInfo(
          name,
          type,
          age,
          gender,
          location,
          description,
          friendlinessRate,
          trainablityRate,
          healthRate,
          adaptibilityRate,
          petURLPhoto,
          userId);

      // Save the pet data in Firestore under the specified document ID
      await _firestore.collection('petsList').doc(PetID).set(newPet.toMap());
      print("Pet added successfully with ID: $PetID");
    } catch (e) {
      print("Error adding pet: $e");
      throw Exception("Failed to add pet");
    }
  }

  Future<List<AdoptionPetInfo>> fetchPets() async {
    try {
      final querySnapshot = await _firestore.collection('petsList').get();

      return querySnapshot.docs.map((doc) {
        return AdoptionPetInfo.fromMap(doc.data());
      }).toList();
    } catch (e) {
      print("Error fetching pets: $e");
      throw Exception("Failed to fetch pets");
    }
  }
}
