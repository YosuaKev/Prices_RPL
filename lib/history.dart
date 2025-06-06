import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoryPage extends StatefulWidget {
  final VoidCallback onBackToHome;

  const HistoryPage({Key? key, required this.onBackToHome}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, String>> history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  // ✅ Muat history dari SharedPreferences
  Future<void> _loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('history');
    if (savedData != null) {
      List<dynamic> jsonList = jsonDecode(savedData);
      setState(() {
        history = jsonList.map((e) => Map<String, String>.from(e)).toList();
      });
    }
  }

  // ✅ Simpan history ke SharedPreferences
  Future<void> _saveHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encoded = jsonEncode(history);
    await prefs.setString('history', encoded);
  }

  // ✅ Tambahkan data baru ke history
  Future<void> _addToHistory(String url) async {
    final now = DateTime.now();
    final timestamp = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} "
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    final newEntry = {
      "url": url,
      "timestamp": timestamp,
    };

    setState(() {
      history.insert(0, newEntry);
    });

    await _saveHistory();
  }

  Future<void> _clearHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('history');
    setState(() {
      history.clear();
    });
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFA3BFFA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: const Text(
          "Are you sure you want to delete?",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("NO", style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(backgroundColor: const Color(0xFFB0BEC5)),
          ),
          TextButton(
            onPressed: () {
              _clearHistory();
              Navigator.pop(context);
            },
            child: const Text("YES", style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(backgroundColor: const Color(0xFF4F6EF7)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0x4D5555ED), Color(0x4D5555ED)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: widget.onBackToHome,
                    ),
                    const Text(
                      "History",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          onPressed: history.isNotEmpty ? _showDeleteConfirmation : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            _addToHistory("https://example.com");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (history.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      "No history available.",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA3BFFA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                history[index]["url"]!,
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              history[index]["timestamp"]!,
                              style: TextStyle(color: Colors.grey[300], fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
