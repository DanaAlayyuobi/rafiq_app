import 'package:flutter/material.dart';
import 'package:rafiq_app/screens/chat_screens/chat_screen.dart';
import 'package:rafiq_app/widget/button_widget.dart';

import '../models/adoption_pet_info.dart';
import '../services/auth_services/auth_service.dart';
import '../widget/labeled_progress_bar.dart';

class PetInfoScreen extends StatefulWidget {
  final AdoptionPetInfo petInfo;

  const PetInfoScreen({super.key, required this.petInfo});

  @override
  State<PetInfoScreen> createState() => _PetInfoScreenState();
}

class _PetInfoScreenState extends State<PetInfoScreen> {
  bool _isFav = false;
  final AuthService _authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 350,
            decoration: const BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: Image.network(
              fit: BoxFit.fill,
              widget.petInfo.petURLPhoto == ""
                  ? "https://cdn.creazilla.com/silhouettes/7966870/cat-footprint-silhouette-000000-xl.png"
                  : widget.petInfo.petURLPhoto,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Image loaded
                }
                return CircularProgressIndicator(); // While loading
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error); // Display on error
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.petInfo.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isFav = !_isFav;
                      });
                    },
                    icon: Icon(_isFav ? Icons.favorite : Icons.favorite_border,
                      size: 30,)),

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.location_pin, color: Colors.deepOrange, size: 30,),
                Text(
                  widget.petInfo.location,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Flexible( // Ensures text wraps to the next line
                  child: Text(
                    widget.petInfo.description,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(child: LabeledProgressBar(
                    label: 'Friendliness',
                    progress: widget.petInfo.friendlinessRate / 10,
                    )),
                 Expanded(child: LabeledProgressBar(
                  label: 'Trainability', progress: widget.petInfo.trainablityRate/10,)),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: LabeledProgressBar(
                  label: 'Adaptibility', progress: widget.petInfo.adaptibilityRate/10,)),
                Expanded(
                    child: LabeledProgressBar(label: 'Health', progress:widget.petInfo.healthRate ,)),
              ],
            ),
          ),
          const SizedBox(height: 80,),
          ButtonWidget(buttonLabel: 'Adopt Me!', onTap: () async {
            print(widget.petInfo.name + " "+widget.petInfo.userId);
            String myId = _authService.getCurrentUser()!.uid;
            if(myId!=widget.petInfo.userId){
            String? userEmail = await _authService.getEmailByUserId(widget.petInfo.userId);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen(reciveEmail:userEmail??"" , reciverId: widget.petInfo.userId)),
            );}
            else{
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("You can't massage your self!"),));
            }
          },),
        ],
      ),
    );
  }
}
