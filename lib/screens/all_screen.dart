import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafiq_app/screens/Login_screen.dart';
import 'package:rafiq_app/screens/chat_screen.dart';
import 'package:rafiq_app/screens/favorite_screen.dart';
import 'package:rafiq_app/screens/home_screen.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});

  @override
  State<AllScreen> createState() => _AllScreenState();
}

List<Widget> _screens = [
  const ChatScreen(),
  const HomeScreen(),
  const FavoriteScreen()
];

class _AllScreenState extends State<AllScreen> {
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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFFFFCB00), //Color(0x89EFD46D),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
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
        type: BottomNavigationBarType.fixed,
        currentIndex: _screenIndex,
        onTap: (value) {
          setState(() {
            _screenIndex = value;
          });
        },
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        selectedItemColor: Theme.of(context).colorScheme.primary,
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
