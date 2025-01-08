import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/adoption_pet_info.dart';

class PetListService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addNewPet(String name,
      String type,
      double age,
      String gender,
      String location,
      String description,
      String petURLPhoto,
      double friendlinessRate,
      double trainablityRate,
      double healthRate,
      double adaptibilityRate,) async {
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
          userId,
          PetID);

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

  // Fetch the list of favorite pets for the current user
  Future<List<AdoptionPetInfo>> getFavoritePets(String userId) async {
    try {
      // Fetch the user document
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(
          userId).get();

      if (userDoc.exists) {
        // Get the list of favorite pet IDs
        List<dynamic>? favPetIds = (userDoc.data() as Map<String, dynamic>?)?['favorites'];


        if (favPetIds != null && favPetIds.isNotEmpty) {
          // Fetch pet details for each ID
          List<AdoptionPetInfo> favPets = [];
          for (String petId in favPetIds) {
            DocumentSnapshot petDoc = await _firestore.collection('pets').doc(
                petId).get();

            if (petDoc.exists) {
              favPets.add(AdoptionPetInfo.fromMap(
                  petDoc.data() as Map<String, dynamic>));
            } else {
              print('Pet document does not exist for ID: $petId');
            }
          }
          return favPets;
        } else {
          print('No favorite pet IDs found for user: $userId');
          return [];
        }
      } else {
        print('User document does not exist: $userId');
        return [];
      }
    } catch (e) {
      print('Error fetching favorite pets: $e + $userId');
      return [];
    }
  }
}