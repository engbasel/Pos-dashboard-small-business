import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/db/login_sql_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/user_list.dart';

class UserLogsView extends StatefulWidget {
  const UserLogsView({super.key});

  @override
  State<UserLogsView> createState() => _UserLogsViewState();
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

  Future<void> confirmDelete(int id) async {
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
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate('Password'),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              // child: const Text('Cancel'),
              child: Text(
                AppLocalizations.of(context).translate('Cancel'),
              ),

              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              // child: const Text('Delete'),
              child: Text(
                AppLocalizations.of(context).translate('Cancel'),
              ),
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
          // title: const Text('Invalid Password'),
          title: Text(
            AppLocalizations.of(context).translate('InvalidPassword'),
          ),
          // content: const Text('The password you entered is incorrect.'),
          content: Text(
            AppLocalizations.of(context)
                .translate('Thepasswordyouenteredisincorrect'),
          ),

          actions: <Widget>[
            TextButton(
              child: Text(
                AppLocalizations.of(context).translate('Ok'),
              ),
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
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(localizations.translate('userLogs')),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserList(users: users, onDelete: confirmDelete),
          ],
        ),
      ),
    );
  }
}