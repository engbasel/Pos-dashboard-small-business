import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_snackbar.dart';
import 'package:pos_dashboard_v1/features/authentication/database/AuthService.dart';
import 'package:pos_dashboard_v1/features/authentication/models/createAccounts.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

import '../../../core/widgets/custom_small_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final AuthService _authService = AuthService();

  void showEmptyFieldSnackbar(String fieldName) {
    CustomSnackBar.show(
      context,
      '${AppLocalizations.of(context).translate(fieldName)} ${AppLocalizations.of(context).translate('cannotBeEmpty')}',
      backgroundColor: Colors.red,
      textColor: Colors.white,
      icon: Icons.error,
    );
  }

  void register() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String phone = phoneController.text;

    // Check for empty fields
    if (name.isEmpty) {
      showEmptyFieldSnackbar('name');
      return;
    }
    if (email.isEmpty) {
      showEmptyFieldSnackbar('email');
      return;
    }
    if (password.isEmpty) {
      showEmptyFieldSnackbar('password');
      return;
    }
    if (phone.isEmpty) {
      showEmptyFieldSnackbar('phone');
      return;
    }

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
      CustomSnackBar.show(
        context,
        AppLocalizations.of(context).translate('accountCreated'),
        backgroundColor: Colors.green,
        textColor: Colors.white,
        icon: Icons.create,
      );
    } else {
      // Show error message
      CustomSnackBar.show(
        context,
        AppLocalizations.of(context).translate('registrationFailed'),
        backgroundColor: Colors.red,
        textColor: Colors.white,
        icon: Icons.error,
      );
    }
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelKey,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate(labelKey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        obscureText: obscureText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('createAccount'),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            buildTextField(
              controller: nameController,
              labelKey: AppLocalizations.of(context).translate('nameLabel'),
            ),
            buildTextField(
              controller: emailController,
              labelKey: AppLocalizations.of(context).translate('emailLabel'),
            ),
            buildTextField(
              controller: passwordController,
              labelKey: AppLocalizations.of(context).translate('Password'),
              obscureText: true,
            ),
            buildTextField(
              controller: phoneController,
              labelKey: AppLocalizations.of(context).translate('phone'),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: CustomSmallButton(
                onTap: register,
                text: AppLocalizations.of(context).translate('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
