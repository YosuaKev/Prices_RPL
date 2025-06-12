import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:ui';
import 'first.dart';
import 'settings.dart';
import 'history.dart';
import 'result_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Scanner',
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/homeScreenbackground.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: const Color(0x556D79DD),
              ),
            ),
          ),
          MainScreen(),
        ],
      ),
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: const Color(0x556D79DD),
        scaffoldBackgroundColor: Colors.transparent,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

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
    final List<Widget> tabs = [
      HistoryPage(onBackToHome: _goToHomeTab),
      Home(),
      SettingsPage(onBackToHome: _goToHomeTab),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: tabs[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0x556D79DD),
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() => _currentIndex = index);
                },
                backgroundColor: Colors.transparent,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white60,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
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
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool _isHoveringTab0 = false;
  bool _isHoveringTab1 = false;

  // Tambahkan fungsi lookupPrice di sini
  double? lookupPrice(String barcode) {
    Map<String, double> priceDatabase = {
      '1234567890': 15.0,
      '9876543210': 25.0,
      '1111111111': 30.0,
    };
    return priceDatabase[barcode]; // akan return null jika tidak ditemukan
  }

  Future<void> _pickImageAndScanBarcode() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final inputImage = InputImage.fromFilePath(pickedFile.path);
      final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

      final List<Barcode> barcodes = await barcodeScanner.processImage(inputImage);

      for (Barcode barcode in barcodes) {
        final String value = barcode.rawValue ?? '';
        print('Barcode value: $value');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultPage(
              barcodeValue: value,
              price: lookupPrice(value)?.toString(),
              scanTime: DateTime.now(),
            ),
          ),
        );
      }

      await barcodeScanner.close();
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 70),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 45,
              width: 140,
              decoration: BoxDecoration(
                color: const Color(0x556D79DD),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: MouseRegion(
                        onEnter: (_) => setState(() => _isHoveringTab0 = true),
                        onExit: (_) => setState(() => _isHoveringTab0 = false),
                        child: GestureDetector(
                          onTap: () {
                            _tabController.animateTo(0);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: _isHoveringTab0 ? Colors.white24 : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.qr_code,
                              color: _tabController.index == 0 ? Colors.white : Colors.white60,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: MouseRegion(
                        onEnter: (_) => setState(() => _isHoveringTab1 = true),
                        onExit: (_) => setState(() => _isHoveringTab1 = false),
                        child: GestureDetector(
                          onTap: _pickImageAndScanBarcode,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _isHoveringTab1 ? Colors.white24 : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.photo_library,
                              color: _isHoveringTab1 ? Colors.white : Colors.white60,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              First(),
            ],
          ),
        ),
      ],
    );
  }
}
