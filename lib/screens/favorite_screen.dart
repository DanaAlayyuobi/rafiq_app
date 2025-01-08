import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/adoption_pet_info.dart';
import '../services/pet_list_service/pet_list_sevice.dart';
import '../widget/adoption_card.dart';
import '../services/auth_services/auth_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreen();
}

class _FavoriteScreen extends State<FavoriteScreen> {
  List<AdoptionPetInfo?> _favList = [];
  bool _isLoading = false;
  final PetListService _petListService = PetListService();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _fetchFavoritePets();
  }

  // Fetch favorite pets from Firestore when the screen loads
  Future<void> _fetchFavoritePets() async {
    setState(() {
      _isLoading = true;
    });

    String userId = _authService.getCurrentUser()!.uid;
    List<AdoptionPetInfo> pets = await _petListService.getFavoritePets(userId);

    setState(() {
      _favList = pets;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Favorite Pets",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
              child: _favList.isEmpty
                  ? const Center(child: Text("No favorite pets available."))
                  : ListView.builder(
                itemCount: _favList.length,
                itemBuilder: (context, index) {
                  final favPet = _favList[index];

                  if (favPet != null) {
                    return AdoptionCard(pet: favPet);
                  } else {
                    return const Center(child: Text("Invalid pet data"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
