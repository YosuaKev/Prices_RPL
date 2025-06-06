import 'package:flutter/material.dart';
import 'dart:ui';
import 'first.dart';
import 'second.dart';
import 'settings.dart';
import 'history.dart';

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

  void _goToHomeTab() {
    setState(() {
      _currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabs = [
      HistoryPage(onBackToHome: _goToHomeTab),
      Home(),
      SettingsPage(onBackToHome: _goToHomeTab),
    ];

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
          bottomNavigationBar: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() => _currentIndex = index);
                },
                backgroundColor: const Color(0xE66D79DD),
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
          ),
        ),
      ],
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double tabBarHeight = kBottomNavigationBarHeight;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(tabBarHeight + 10),
          child: SafeArea(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                child: Container(
                  height: kBottomNavigationBarHeight,
                  color: const Color(0xE66D79DD),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      TabBar(
                        indicatorColor: Colors.white,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white70,
                        indicatorWeight: 3,
                        labelStyle: TextStyle(fontSize: 12),
                        tabs: const [
                          Tab(icon: Icon(Icons.qr_code), text: 'Generator'),
                          Tab(icon: Icon(Icons.camera_alt), text: 'Scanner'),
                        ],
                      ),
                      Positioned(
                        child: IconButton(
                          onPressed: () {
                            // aksi saat tombol flash ditekan
                          },
                          icon: Icon(Icons.flash_on, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
