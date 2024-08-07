import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/authentication/database/AuthService.dart';
import 'package:pos_dashboard_v1/features/authentication/models/createAccounts.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final AuthService _authService = AuthService();

  void _register() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String phone = _phoneController.text;

    var newAccount = Account(
      name: name,
      email: email,
      password: password,
      phone: phone,
      isAdmin: 0,
      isVerified: 0,
      isDeleted: 0,
    );

    int result = await _authService.register(newAccount);
    print("Register result: $result");

    if (result > 0) {
      // Navigate to login screen
      Navigator.pop(context);
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
