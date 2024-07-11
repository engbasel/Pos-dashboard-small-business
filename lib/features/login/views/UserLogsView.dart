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

  Future<void> _confirmDelete(int id) async {
    final TextEditingController passwordController = TextEditingController();
    const String adminPassword = 'admin';

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must enter password
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter admin password to delete user:'),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                if (passwordController.text == adminPassword) {
                  deleteUser(id);
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                  _showInvalidPasswordDialog();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showInvalidPasswordDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Password'),
          content: const Text('The password you entered is incorrect.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fd),
      appBar: AppBar(title: const Text('User Logs')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserList(users: users, onDelete: _confirmDelete),
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
