import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String productName = "NAMA PRODUK MAKANAN";

  void _showRenameDialog() {
    TextEditingController controller = TextEditingController(text: productName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFA3BFFA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text("Rename", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(backgroundColor: Color(0xFFB0BEC5)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                productName = controller.text;
              });
              Navigator.pop(context);
            },
            child: Text("OK", style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(backgroundColor: Color(0xFF4F6EF7)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA3BFFA), Color(0xFF4F6EF7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      "Result",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 48), // Spacer untuk tombol kanan
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Text(
                      "JMC Product",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "18 Dec 2022 - 10:50 PM",
                      style: TextStyle(color: Colors.grey[300], fontSize: 12),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: _showRenameDialog,
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color(0x80A3BFFA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              productName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Rp 99.999.99",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "087839876998",
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.share, color: Colors.white),
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: Color(0x80A3BFFA),
                          ),
                        ),
                        SizedBox(width: 16),
                        IconButton(
                          icon: Icon(Icons.copy, color: Colors.white),
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: Color(0x80A3BFFA),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}