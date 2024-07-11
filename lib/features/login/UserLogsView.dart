import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/login/sql.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fd),
      appBar: AppBar(title: const Text('User Logs')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserList(users: users),
          ],
        ),
      ),
    );
  }
}

class UserList extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  const UserList({super.key, required this.users});

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
          ),
        );
      },
    );
  }
}
