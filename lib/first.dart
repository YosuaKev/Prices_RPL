import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  TextEditingController controller = TextEditingController();
  String code = '';

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
                children: [
                  const Text(
                    "Generate QR Code",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Input Field
                  TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Enter text or code',
                      hintStyle: const TextStyle(color: Colors.black45),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Generate Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        code = controller.text.trim();
                      });
                    },
                    child: const Text(
                      "Create QR Code",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // QR Code Preview
                  code.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: BarcodeWidget(
                            barcode: Barcode.qrCode(),
                            data: code,
                            width: 200,
                            height: 200,
                          ),
                        )
                      : const Text(
                          'Enter code and press "Create"',
                          style: TextStyle(color: Colors.white70),
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
