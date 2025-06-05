import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool vibrateOnScan = true;
  bool beepOnScan = false;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      "Settings",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 48), // spacer
                  ],
                ),
              ),

              // Settings list
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    const Text(
                      "GENERAL SETTINGS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Vibrate switch
                    SwitchListTile(
                      title: const Text(
                        "Vibrate when scan is done",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: vibrateOnScan,
                      onChanged: (value) {
                        setState(() => vibrateOnScan = value);
                      },
                      activeColor: const Color(0xFF4F6EF7),
                    ),

                    // Beep switch
                    SwitchListTile(
                      title: const Text(
                        "Beep when scan is done",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: beepOnScan,
                      onChanged: (value) {
                        setState(() => beepOnScan = value);
                      },
                      activeColor: const Color(0xFF4F6EF7),
                    ),

                    const SizedBox(height: 32),

                    const Text(
                      "SUPPORT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Rate Us
                    ListTile(
                      leading: const Icon(Icons.star, color: Colors.white),
                      title: const Text("Rate Us", style: TextStyle(color: Colors.white)),
                      subtitle: Text(
                        "Your best reward to us",
                        style: TextStyle(color: Colors.grey[300], fontSize: 12),
                      ),
                      onTap: () {
                        // TODO: Implement rating functionality
                      },
                    ),

                    // Share
                    ListTile(
                      leading: const Icon(Icons.share, color: Colors.white),
                      title: const Text("Share app with others", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // TODO: Implement share functionality
                      },
                    ),

                    // Privacy Policy
                    ListTile(
                      leading: const Icon(Icons.description, color: Colors.white),
                      title: const Text("Privacy Policy", style: TextStyle(color: Colors.white)),
                      subtitle: Text(
                        "We care about your privacy",
                        style: TextStyle(color: Colors.grey[300], fontSize: 12),
                      ),
                      onTap: () {
                        // TODO: Show privacy policy
                      },
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
