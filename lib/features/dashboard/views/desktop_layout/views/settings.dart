import 'package:flutter/material.dart';

import '../../../../login/UserLogsView.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('View User Logs'),
            leading: const Icon(Icons.history),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserLogsView()),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Another Setting Option'),
            leading: const Icon(Icons.settings),
            onTap: () {
              // Handle onPressed for another setting option
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Staff '),
            leading: const Icon(Icons.people),
            onTap: () {
              // Handle onPressed for staff data
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Users '),
            leading: const Icon(Icons.person),
            onTap: () {
              // Handle onPressed for users data
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Change Mode'),
            leading: const Icon(Icons.brightness_4),
            onTap: () {
              // Handle onPressed for changing app mode
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Change Language'),
            leading: const Icon(Icons.language),
            onTap: () {
              // Handle onPressed for changing app language
            },
          ),
          const Divider(),
          // Add more ListTiles for additional settings
        ],
      ),
    );
  }
}
