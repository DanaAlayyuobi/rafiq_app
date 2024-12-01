import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafiq_app/widget/banner_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:Icon(Icons.pets),
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            BannerWidget(),
          ],
        ),
      ),
    );
  }
}
