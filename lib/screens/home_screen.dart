import 'package:flutter/material.dart';
import 'package:rafiq_app/models/story.dart';
import 'package:rafiq_app/services/sucess_story_service/success_story_service.dart';
import 'package:rafiq_app/widget/banner_widget.dart';
import 'package:rafiq_app/widget/dropdown_number_widget.dart';
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
  final SuccessStoryService _successStoryService= SuccessStoryService();

  List<AdoptionPetInfo> _adoptionPetList = [];
  List<Story> _storyList = [];

  bool _isLoading = true;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _petURLPhoto = TextEditingController();

  TextEditingController _storyDescriptionController = TextEditingController();
  TextEditingController _storyURLPhoto = TextEditingController();
  TextEditingController _storyTitle = TextEditingController();
  int? _friendlinessRate;
  int? _trainablityRate;
  int? _healthRate;
  int? _adaptibilityRate;

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
    } finally {
      _isLoading = false;
    }
  }

  Future<void> _addPet(BuildContext context) async {
    if (_nameController.text.isNotEmpty &&
        _typeController.text.isNotEmpty &&
        _genderController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _friendlinessRate != null &&
        _trainablityRate != null &&
        _adaptibilityRate != null &&
        _healthRate != null) {
      await _petListService.addNewPet(
        _nameController.text,
        _typeController.text,
        double.tryParse(_ageController.text) ?? 0,
        _genderController.text,
        _locationController.text,
        _descriptionController.text,
        _petURLPhoto.text,
        _friendlinessRate?.toDouble() ?? 0,
        _trainablityRate?.toDouble() ?? 0,
        _adaptibilityRate?.toDouble() ?? 0,
        _healthRate?.toDouble() ?? 0,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pet added successfully!")),
      );
      Navigator.pop(context);
      _ClearPetPostValues();
      _fetchPets(); // Refresh the pet list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
    }
  }

  Future<void> _fetchStories() async {
    try {
      final stories = await _successStoryService.fetchStory();
      setState(() {
        _storyList = stories;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching stories: $error")),
      );
    } finally {
      _isLoading = false;
    }
  }

  Future<void> _addStories(BuildContext context) async {
    if (_storyTitle.text.isNotEmpty &&
        _storyDescriptionController.text.isNotEmpty
        ) {
      await _successStoryService.addNewStory(
        _storyTitle.text,
        _storyDescriptionController.text,
        _storyURLPhoto.text,

      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("story added successfully!")),
      );
      Navigator.pop(context);
      _ClearStoryPostValues();
      _fetchStories(); // Refresh the pet list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
    }
  }

  void _ClearPetPostValues() {
    _nameController.clear();
    _typeController.clear();
    _ageController.clear();
    _genderController.clear();
    _locationController.clear();
    _descriptionController.clear();
    _petURLPhoto.clear();
    setState(() {
      _friendlinessRate = null;
      _trainablityRate = null;
      _healthRate = null;
      _adaptibilityRate = null;
    });
  }

  void _ClearStoryPostValues() {
    _storyTitle.clear();
    _storyDescriptionController.clear();
    _storyURLPhoto.clear();
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
                                urlPhoto: pet.petURLPhoto,
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show dialog to choose between Post Story or Post Pet
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.book),
                      label: const Text("Post a Story"),
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                        _showAddStoryDialog(); // Navigate to post story functionality
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.pets),
                      label: const Text("Post a Pet"),
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                        _showAddPetDialog(); // Show the add pet dialog
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  void _showAddPetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Add a New Pet"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _petURLPhoto,
                      decoration: const InputDecoration(
                        labelText: "Pet URL Photo",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    const Text(
                      "Rates :",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownNumberWidget(
                          selectedValue: _friendlinessRate,
                          onChanged: (newValue) {
                            setState(() {
                              _friendlinessRate = newValue;
                            });
                          },
                          hintText: "Friendliness ",
                        ),
                        const SizedBox(width: 20),
                        DropdownNumberWidget(
                          selectedValue: _trainablityRate,
                          onChanged: (newValue) {
                            setState(() {
                              _trainablityRate = newValue;
                            });
                          },
                          hintText: "Trainablity ",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: DropdownNumberWidget(
                            selectedValue: _adaptibilityRate,
                            onChanged: (newValue) {
                              setState(() {
                                _adaptibilityRate = newValue;
                              });
                            },
                            hintText: "Adaptibility ",
                          ),
                        ),
                        const SizedBox(width: 20),
                        DropdownNumberWidget(
                          selectedValue: _healthRate,
                          onChanged: (newValue) {
                            setState(() {
                              _healthRate = newValue;
                            });
                          },
                          hintText: "Health ",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    _ClearPetPostValues();
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addPet(context);
                  },
                  child: const Text("Add Pet"),
                ),
              ],
            );
          },
        );
      },
    );
  }
  void _showAddStoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Add a New Story"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _storyURLPhoto,
                      decoration: const InputDecoration(
                        labelText: "Story URL Photo",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _storyTitle,
                      decoration: const InputDecoration(
                        labelText: "Story Title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _storyDescriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Story Description",
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
                    _ClearStoryPostValues();                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addStories(context);
                  },
                  child: const Text("Add Story"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
