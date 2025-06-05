import 'package:flutter/material.dart';
import 'dart:ui';
import 'first.dart';
import 'second.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Scanner',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.transparent,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1;

  final List<Widget> _tabs = [
    HistoryPage(),
    Home(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/homeScreenbackground.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: _tabs[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() => _currentIndex = index);
            },
            backgroundColor: Colors.white.withOpacity(0.2),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner),
                label: 'Scanner',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.2),
          title: const Text('Home Screen'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.flash_on),
              onPressed: () {
                // Tambahkan logika flashlight jika dibutuhkan
              },
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.qr_code), text: 'Generator'),
              Tab(icon: Icon(Icons.camera_alt), text: 'Scanner'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            First(),
            Second(),
          ],
        ),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'History Page',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
