import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/authentication/create_account/models/createAccounts.dart';
import '../database/createAccoutesdatabasHelpers.dart';

class Createdaccountsuser extends StatelessWidget {
  const Createdaccountsuser({super.key});

  Future<List<Account>> fetchAccounts() async {
    AuthService authService = AuthService();
    return await authService.getAllAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Created Accounts')),
      body: FutureBuilder<List<Account>>(
        future: fetchAccounts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching accounts'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No accounts found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Account account = snapshot.data![index];
                return ListTile(
                  // title: Text(account.name),
                  subtitle: Text(account.email),
                  trailing: Text(account.phone ?? ''),
                );
              },
            );
          }
        },
      ),
    );
  }
}
