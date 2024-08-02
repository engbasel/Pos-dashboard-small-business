import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class UserList extends StatelessWidget {
  final List<Map<String, dynamic>> users;
  final Function(int) onDelete;

  const UserList({super.key, required this.users, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white70,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(
                '${localizations.translate('username')}: ${users[index]['username']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${localizations.translate('privilege')}: ${users[index]['privilege']}'),
                Text(
                    '${localizations.translate('email')}: ${users[index]['email']}'),
                Text(
                    '${localizations.translate('createdAt')}: ${users[index]['createdAt']}'),
                Text(
                    '${localizations.translate('createdTime')}: ${users[index]['createdTime']}'),
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
