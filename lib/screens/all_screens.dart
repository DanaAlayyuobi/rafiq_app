import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafiq_app/screens/Login_screen.dart';
import 'package:rafiq_app/screens/chat_screens/main_chat_screen.dart';
import 'package:rafiq_app/screens/favorite_screen.dart';
import 'package:rafiq_app/screens/home_screen.dart';

class AllScreens extends StatefulWidget {
  const AllScreens({super.key});

  @override
  State<AllScreens> createState() => _AllScreensState();
}

List<Widget> _screens = [
  MainChatScreen(),
   HomeScreen(),
   FavoriteScreen()
];

class _AllScreensState extends State<AllScreens> {
  int _screenIndex = 1;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.pets)),
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          )
        ],
        iconTheme: const IconThemeData(
            color: Colors.white,
            size: 30// Set the color of the back button to white
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFFFBEAA3), //Color(0x89EFD46D),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: const Color(0xFFFFF5CD),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      child: Image.asset('assets/images/rafiqlogo.png'),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Row(
                  children: [
                    Icon(
                      Icons.home,
                      size: 28,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Home',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    _screenIndex = 1;
                  });

                  Navigator.pop(context);
                },
              ),
              const Divider(
                color: Color(0x0f836164),
                thickness: 2,
              ),
              ListTile(
                title: const Row(
                  children: [
                    Icon(
                      Icons.chat,
                      size: 28,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Chats',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    _screenIndex = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              const Divider(
                color: Color(0x0f836164),
                thickness: 2,
              ),
              ListTile(
                title: const Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 28,

                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Favorites',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    _screenIndex = 2;
                  });
                  Navigator.pop(context);
                },
              ),
              const Divider(
                color: Color(0x0f836164),
                thickness: 2,
              ),
              ListTile(
                title: const Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 28,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Logout',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );                },
              ),
            ],
          ),
        ),
      ),
      body: _screens[_screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        type: BottomNavigationBarType.fixed,
        currentIndex: _screenIndex,
        onTap: (value) {
          setState(() {
            _screenIndex = value;
          });
        },
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.white,
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
      ),
    );
  }
}
