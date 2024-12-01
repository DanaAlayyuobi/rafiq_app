import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafiq_app/screens/chat_screen.dart';
import 'package:rafiq_app/screens/favorite_screen.dart';
import 'package:rafiq_app/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
List<Widget>_screens=[
  ChatScreen(),
  HomeScreen(),
  FavoriteScreen()
];

class _MainScreenState extends State<MainScreen> {
  int _screenIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BottomNavigationBar(
        type:BottomNavigationBarType.fixed ,
        currentIndex:_screenIndex ,
        onTap: (value){
          setState(() {
            _screenIndex=value;
          });
        },
        unselectedItemColor:Theme
            .of(context)
            .colorScheme
            .onSurface,
        selectedItemColor: Theme
            .of(context)
            .colorScheme
            .primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "CHATS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "HOME",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "FAVORITES",
          ),
        ],
      ) ,
       body: _screens[_screenIndex],
    );
  }
}
