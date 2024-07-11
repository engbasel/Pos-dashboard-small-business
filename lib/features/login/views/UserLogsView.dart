import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/DB/LoginSQL_helper.dart';

class UserLogsView extends StatefulWidget {
  const UserLogsView({super.key});

  @override
  _UserLogsViewState createState() => _UserLogsViewState();
}

class _UserLogsViewState extends State<UserLogsView> {
  final Sqldb sqldb = Sqldb();
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    users = await sqldb.getUserData();
    setState(() {});
  }

  void deleteUser(int id) async {
    await sqldb.deleteUserData(id.toString());
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fd),
      appBar: AppBar(title: const Text('User Logs')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserList(users: users, onDelete: deleteUser),
          ],
        ),
      ),
    );
  }
}

class UserList extends StatelessWidget {
  final List<Map<String, dynamic>> users;
  final Function(int) onDelete;

  const UserList({super.key, required this.users, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
