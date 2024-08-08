import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _soundEnabled = true;
  bool _musicEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _soundEnabled = prefs.getBool('soundEnabled') ?? true;
      _musicEnabled = prefs.getBool('musicEnabled') ?? true;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundEnabled', _soundEnabled);
    await prefs.setBool('musicEnabled', _musicEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Sound'),
            value: _soundEnabled,
            onChanged: (bool value) {
              setState(() {
                _soundEnabled = value;
              });
              _saveSettings(); // Save setting when toggled
            },
          ),
          SwitchListTile(
            title: Text('Background Music'),
            value: _musicEnabled,
            onChanged: (bool value) {
              setState(() {
                _musicEnabled = value;
              });
              _saveSettings(); // Save setting when toggled
            },
          ),
        ],
      ),
    );
  }
}
