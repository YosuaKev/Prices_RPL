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
            colors: [Color(0xFFA3BFFA), Color(0xFF4F6EF7)],
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
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

                  // Result Display
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      scanResult.isEmpty
                          ? 'Scan result will appear here'
                          : scanResult,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
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
