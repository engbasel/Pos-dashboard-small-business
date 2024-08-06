import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/db/Log_file_database_helper.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
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
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          backgroundColor: Colors.white,
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
              child: Text(
                AppLocalizations.of(context).translate('Cancel'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                AppLocalizations.of(context).translate('delete'),
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
          backgroundColor: Colors.white,
          title: Text(
            AppLocalizations.of(context).translate('InvalidPassword'),
          ),
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
      appBar: AppBar(
        title: Text(localizations.translate('userLogs')),
        backgroundColor: Colors.white,
      ),
      backgroundColor: ColorsManager.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              UserList(users: users, onDelete: confirmDelete),
            ],
          ),
        ),
      ),
    );
  }
}
