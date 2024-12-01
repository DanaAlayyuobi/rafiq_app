import 'package:flutter/material.dart';
import 'package:rafiq_app/screens/Login_screen.dart';
import 'package:rafiq_app/theme.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:LoginScreen(),
        theme:lightMode
    );
  }
}
