import 'package:flutter/material.dart';

class LogFile extends StatelessWidget {
  const LogFile({
    super.key,
    required this.users,
  });

  final List<Map<String, dynamic>> users;

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

// import 'package:flutter/material.dart';

// class LogFile extends StatelessWidget {
//   const LogFile({
//     super.key,
//     required this.users,
//   });

//   final List<Map<String, dynamic>> users;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Logs'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemCount: users.length,
//           itemBuilder: (context, index) {
//             return Card(
//               margin: const EdgeInsets.symmetric(vertical: 8),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Username: ${users[index]['username']}',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text('Birthday: ${users[index]['birthday']}'),
//                     Text('Privilege: ${users[index]['privilege']}'),
//                     Text('Gender: ${users[index]['gender']}'),
//                     Text('Email: ${users[index]['email']}'),
//                     Text('Branch: ${users[index]['branch']}'),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
