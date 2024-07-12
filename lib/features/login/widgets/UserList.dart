import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final List<Map<String, dynamic>> users;
  final Function(int) onDelete;

  const UserList({super.key, required this.users, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
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
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onDelete(users[index]['id']),
            ),
          ),
        );
      },
    );
  }
}
