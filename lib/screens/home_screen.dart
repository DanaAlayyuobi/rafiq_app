import 'package:flutter/material.dart';
import 'package:rafiq_app/widget/banner_widget.dart';
import '../models/adoption_pet_info.dart';
import '../services/pet_list_service/pet_list_sevice.dart';
import '../widget/adoption_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PetListService _petListService = PetListService();
  List<AdoptionPetInfo> _adoptionPetList = [];
  bool _isLoading = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPets();
  }

  Future<void> _fetchPets() async {
    try {
      final pets = await _petListService.fetchPets();
      setState(() {
        _adoptionPetList = pets;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching pets: $error")),
      );
    }finally{
      _isLoading = false;

    }
  }

  Future<void> _addPet(BuildContext context) async {
    if (_nameController.text.isNotEmpty &&
        _typeController.text.isNotEmpty &&
        _genderController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      await _petListService.addNewPet(
        _nameController.text,
        _typeController.text,
        double.tryParse(_ageController.text) ?? 0,
        _genderController.text,
        _locationController.text,
        _descriptionController.text,
        0,
        0,
        0,
        0,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pet added successfully!")),
      );
      Navigator.pop(context);
      _fetchPets(); // Refresh the pet list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
    }
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
            const BannerWidget(),
            const SizedBox(height: 16),
            const Text(
              "Explore Pets",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: _adoptionPetList.isEmpty
                        ? const Center(child: Text("No pets available."))
                        : ListView.builder(
                            itemCount: _adoptionPetList.length,
                            itemBuilder: (context, index) {
                              final pet = _adoptionPetList[index];
                              return AdoptionCard(
                                name: pet.name,
                                age: pet.age,
                                type: pet.type,
                                Gender: pet.gender,
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Add a New Pet"),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: "Pet Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _typeController,
                        decoration: const InputDecoration(
                          labelText: "Pet Type",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          labelText: "Pet Age",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _genderController,
                        decoration: const InputDecoration(
                          labelText: "Pet Gender",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          labelText: "Location",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: "Description",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed:(){ _addPet(context);},
                    child: const Text("Add Pet"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
