import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui';

class ResultPage extends StatefulWidget {
  final String barcodeValue;
  final DateTime scanTime;
  final String? productName;
  final String? price;

  ResultPage({
    required this.barcodeValue,
    required this.scanTime,
    this.productName,
    this.price,
  });

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String productName = '';
  String? productPrice;

  @override
  void initState() {
    super.initState();
    productName = widget.productName ?? '';
    productPrice = widget.price;
    saveToHistory();
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    final barcode = widget.barcodeValue;
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/products/$barcode'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          productName = data['name'] ?? barcode;
          productPrice = data['price'] != null
                ? data['price'].toString()
                : productPrice;
        });
        saveToHistory(); // update history with fetched data
      } else {
        print('Produk tidak ditemukan, status: ${response.statusCode}');
      }
    } catch (e) {
      print('Gagal mengambil data produk: $e');
    }
  }

  Future<void> saveToHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('history');

    List<Map<String, String>> currentHistory = [];

    if (savedData != null) {
      List<dynamic> jsonList = jsonDecode(savedData);
      currentHistory = jsonList
          .map((e) => Map<String, String>.from(e))
          .toList();
    }

    currentHistory.add({
      'url': widget.barcodeValue,
      'timestamp': DateTime.now().toString(),
      'name': productName,
      'price': productPrice ?? '',
    });

    await prefs.setString('history', jsonEncode(currentHistory));
  }

  String get displayProductName =>
      productName.isNotEmpty ? productName : widget.barcodeValue;

  void _showRenameDialog() {
    TextEditingController controller =
        TextEditingController(text: displayProductName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFA3BFFA),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
            style: TextButton.styleFrom(
                backgroundColor: Color(0xFFB0BEC5)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                productName = controller.text;
              });
              saveToHistory();
              Navigator.pop(context);
            },
            child: Text("OK", style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(
                backgroundColor: Color(0xFF4F6EF7)),
          ),
        ],
      ),
    );
  }

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
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Color(0x556D79DD)),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back,
                            color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        "Result",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 48),
                    ],
                  ),
                ),
                // Info
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        "Product",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _formatDateTime(widget.scanTime),
                        style: TextStyle(
                            color: Colors.grey[300], fontSize: 12),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: _showRenameDialog,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0x80A3BFFA),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                displayProductName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              if (productPrice != null &&
                                  productPrice!.isNotEmpty) ...[
                                SizedBox(height: 8),
                                Text(
                                  productPrice!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                              SizedBox(height: 8),
                              Text(
                                widget.barcodeValue,
                                style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 12),
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
                            icon:
                                Icon(Icons.share, color: Colors.white),
                            onPressed: () {
                              Share.share(
                                "$displayProductName\n${widget.barcodeValue}\n${productPrice ?? 'Harga tidak tersedia'}",
                              );
                            },
                            style: IconButton.styleFrom(
                                backgroundColor:
                                    Color(0x80A3BFFA)),
                          ),
                          SizedBox(width: 16),
                          IconButton(
                            icon: Icon(Icons.copy,
                                color: Colors.white),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                text:
                                    "$displayProductName\n${widget.barcodeValue}\n${productPrice ?? 'Harga tidak tersedia'}",
                              ));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Disalin ke clipboard')),
                              );
                            },
                            style: IconButton.styleFrom(
                                backgroundColor:
                                    Color(0x80A3BFFA)),
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
      ],
    );
  }

  String _formatDateTime(DateTime dt) {
    return "${dt.day.toString().padLeft(2, '0')} "
        "${_monthName(dt.month)} ${dt.year} - "
        "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
