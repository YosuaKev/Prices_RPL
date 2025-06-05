import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HistoryPage(),
    );
  }
}

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, String>> history = [
    {"url": "https://itunes.com", "timestamp": "Dec 2022 - 10:50 PM"},
    {"url": "https://itunes.com", "timestamp": "Dec 2022 - 10:50 PM"},
    {"url": "https://itunes.com", "timestamp": "Dec 2022 - 10:50 PM"},
  ];

  void _clearHistory() {
    setState(() {
      history.clear();
    });
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFA3BFFA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          "Are you sure you want to delete?",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("NO", style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(backgroundColor: Color(0xFFB0BEC5)),
          ),
          TextButton(
            onPressed: () {
              _clearHistory();
              Navigator.pop(context);
            },
            child: Text("YES", style: TextStyle(color: Colors.white)),
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
                      "History",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: history.isNotEmpty ? _showDeleteConfirmation : null,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color(0x80A3BFFA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            history[index]["url"]!,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF4F6EF7),
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Browse"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}