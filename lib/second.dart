import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner_plus/flutter_barcode_scanner_plus.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  String scanResult = '';

  Future<void> scanCode() async {
    try {
      String result = await FlutterBarcodeScanner.scanBarcode(
        '#FF6666', 'Cancel', true, ScanMode.BARCODE);

      if (!mounted) return;

      setState(() {
        scanResult = result == '-1' ? 'Cancelled' : result;
      });
    } catch (e) {
      setState(() {
        scanResult = 'Error occurred while scanning';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
            Color(0x4D5555ED), 
            Color(0x4D5555ED), 
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Scan Barcode / QR Code",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Scan Box Placeholder
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Icon(Icons.qr_code_scanner,
                          size: 80, color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Scan Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: scanCode,
                    child: const Text(
                      'Scan QR / Barcode',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
