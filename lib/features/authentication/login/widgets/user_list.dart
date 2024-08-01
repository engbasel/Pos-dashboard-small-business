// import 'package:flutter/material.dart';

// class UserList extends StatelessWidget {
//   final List<Map<String, dynamic>> users;
//   final Function(int) onDelete;

//   const UserList({super.key, required this.users, required this.onDelete});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       reverse: true,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: users.length,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           child: ListTile(
//             title: Text('Username: ${users[index]['username']}'),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Birthday: ${users[index]['birthday']}'),
//                 Text('Privilege: ${users[index]['privilege']}'),
//                 Text('Gender: ${users[index]['gender']}'),
//                 Text('Email: ${users[index]['email']}'),
//                 Text('Branch: ${users[index]['branch']}'),
//               ],
//             ),
//             trailing: IconButton(
//               icon: const Icon(Icons.delete),
//               onPressed: () => onDelete(users[index]['id']),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

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
                    '${localizations.translate('birthday')}: ${users[index]['birthday']}'),
                Text(
                    '${localizations.translate('privilege')}: ${users[index]['privilege']}'),
                Text(
                    '${localizations.translate('gender')}: ${users[index]['gender']}'),
                Text(
                    '${localizations.translate('email')}: ${users[index]['email']}'),
                Text(
                    '${localizations.translate('branch')}: ${users[index]['branch']}'),
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
