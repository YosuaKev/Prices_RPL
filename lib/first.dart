import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner_plus/flutter_barcode_scanner_plus.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  String scanResult = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scanCode();
    });
  }

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

                  // Tombol scan dihapus jadi tidak ada

                  // Display scan result
                  Text(
                    scanResult.isEmpty ? 'Scan result will appear here' : scanResult,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                    textAlign: TextAlign.center,
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