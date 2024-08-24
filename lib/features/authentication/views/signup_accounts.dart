import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_snackbar.dart';
import 'package:pos_dashboard_v1/features/authentication/database/auth_service.dart';
import 'package:pos_dashboard_v1/features/authentication/models/account_model.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
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
      showEmptyFieldSnackbar(AppLocalizations.of(context).translate('name'));
      return;
    }
    if (email.isEmpty) {
      showEmptyFieldSnackbar(
          AppLocalizations.of(context).translate('emailLabel'));
      return;
    }
    if (password.isEmpty) {
      showEmptyFieldSnackbar(
          AppLocalizations.of(context).translate('Password'));
      return;
    }
    if (phone.isEmpty) {
      showEmptyFieldSnackbar(AppLocalizations.of(context).translate('phone'));
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
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context).translate('createAccount'),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .2),
            buildTextField(
              controller: nameController,
              labelKey: AppLocalizations.of(context).translate('name'),
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
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
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
