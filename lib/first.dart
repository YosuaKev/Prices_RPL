import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner_plus/flutter_barcode_scanner_plus.dart';
import 'result_page.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  double? lookupPrice(String barcode) {
  const productPrices = {
    '1234567890': 10.99,
    '0987654321': 5.49,
    '1122334455': 7.25,
  };

  return productPrices[barcode];
}

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> onScanDone() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 100);
    }

    await _audioPlayer.play(AssetSource('beep_sound.mp3'));
  }

  void _showScanFinishedMessage() {
    setState(() {
      scanResult = 'Scan selesai!';
    });
  }

  String scanResult = '';

  Future<void> scanCode() async {
    try {
      String result = await FlutterBarcodeScanner.scanBarcode(
        '#FF6666', 'Cancel', true, ScanMode.BARCODE);

      if (!mounted) return;

      if (result != '-1') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultPage(
               barcodeValue: result,
               price: lookupPrice(result)?.toString(), 
               scanTime: DateTime.now(),
            ),
          ),
        );
        
        await onScanDone();
        _showScanFinishedMessage();

      } else {
        setState(() {
          scanResult = 'Cancelled';
        });
      }
    } catch (e) {
      setState(() {
        scanResult = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Scan Barcode",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  
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

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[300],
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: scanCode,
                    child: const Text(
                      'START SCAN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    scanResult,
                    style: const TextStyle(color: Colors.white70),
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
