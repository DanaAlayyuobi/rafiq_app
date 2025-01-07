import 'package:flutter/material.dart';
import 'package:rafiq_app/screens/pet_info.dart';

class AdoptionCard extends StatelessWidget {
  final String name;
  final String type;
  final double age;
  final String Gender;
  final String urlPhoto;

  const AdoptionCard({
    super.key,
    required this.name,
    required this.type,
    required this.age,
    required this.Gender,
    required this.urlPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PetInfo()));
          },
          child: Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  // Shadow color with transparency
                  offset: Offset(0, 4),
                  // Horizontal and vertical offset
                  blurRadius: 10,
                  // Blurring the shadow
                  spreadRadius: 2, // How far the shadow spreads
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Container(
                  height: 120,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Image.network(
                    fit: BoxFit.fill,
                    urlPhoto == ""
                        ? "https://cdn.creazilla.com/silhouettes/7966870/cat-footprint-silhouette-000000-xl.png"
                        : urlPhoto,
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
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text("Type : $type", style: const TextStyle(fontSize: 18)),
                    Text("Age : $age", style: const TextStyle(fontSize: 18)),
                    Text("Gender : $Gender ",
                        style: const TextStyle(fontSize: 18)),
                  ],
                )
              ]),
            ),
          ),
        ));
  }
}
