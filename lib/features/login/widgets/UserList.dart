import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  const UserList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text('Username: ${users[index]['username']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Birthday: ${users[index]['birthday']}'),
                Text('Privilege: ${users[index]['privilege']}'),
                Text('Gender: ${users[index]['gender']}'),
                Text('Email: ${users[index]['email']}'),
                Text('Branch: ${users[index]['branch']}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
