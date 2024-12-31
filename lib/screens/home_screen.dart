import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafiq_app/widget/banner_widget.dart';

import '../widget/adoption_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BannerWidget(),
            SizedBox(height:16 ,),
            Text(
              "Explore Pets ",
              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
            ),
            SizedBox(height:8 ,),

            AdoptionCard(name: 'BAtt Wheii',age: 20,type: "Cat",Gender: "Female",),

          ],
        ),
      ),
    );
  }
}
