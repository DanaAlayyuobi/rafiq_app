import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rafiq_app/screens/Login_screen.dart';
import 'package:rafiq_app/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
