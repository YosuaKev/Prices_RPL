import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback onBackToHome;

  const SettingsPage({Key? key, required this.onBackToHome}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool vibrateOnScan = true;
  bool beepOnScan = false;

  final AudioPlayer _audioPlayer = AudioPlayer();

  // Fungsi simulasi scan selesai
  void _onScanDone() async {
    if (vibrateOnScan) {
      if (await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate(duration: 100);
      }
    }

    if (beepOnScan) {
      await _audioPlayer.play(AssetSource('beep_sound.mp3'));
    }
  }

  // Fungsi membuka URL di browser (Rate Us, Privacy Policy)
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open $url')),
      );
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
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        widget.onBackToHome();
                      },
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
                      activeColor: const Color(0xFF5555ED),
                    ),

                    const SizedBox(height: 24),

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
                      title:
                          const Text("Rate Us", style: TextStyle(color: Colors.white)),
                      subtitle: Text(
                        "Your best reward to us",
                        style: TextStyle(color: Colors.grey[300], fontSize: 12),
                      ),
                      onTap: () {
                        // Contoh link Play Store
                        _launchURL('https://play.google.com/store/apps/details?id=com.example.app');
                      },
                    ),

                    // Share
                    ListTile(
                      leading: const Icon(Icons.share, color: Colors.white),
                      title: const Text("Share app with others",
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Share.share(
                          'Hey, coba aplikasi ini: https://play.google.com/store/apps/details?id=com.example.app',
                          subject: 'Check out this app!',
                        );
                      },
                    ),

                    // Privacy Policy
                    ListTile(
                      leading: const Icon(Icons.description, color: Colors.white),
                      title:
                          const Text("Privacy Policy", style: TextStyle(color: Colors.white)),
                      subtitle: Text(
                        "We care about your privacy",
                        style: TextStyle(color: Colors.grey[300], fontSize: 12),
                      ),
                      onTap: () {
                        // Contoh link Privacy Policy
                        _launchURL('https://www.example.com/privacy-policy');
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
