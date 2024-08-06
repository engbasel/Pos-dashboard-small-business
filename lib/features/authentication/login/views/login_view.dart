import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/features/authentication/create_account/database/createAccoutesdatabasHelpers.dart';
import 'package:pos_dashboard_v1/features/authentication/create_account/views/sigenUpAccunts.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../core/widgets/layout_builder_resize_screens_differant_sizes.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:pos_dashboard_v1/features/authentication/create_account/models/createAccounts.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void login() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;

      Account? account = await _authService.login(email, password);

      if (account != null) {
        CustomSnackBar.show(
          context,
          AppLocalizations.of(context).translate('loginSuccess'),
          backgroundColor: Colors.green,
          textColor: Colors.white,
          icon: Icons.check_circle,
        );

        // Navigate to the main screen
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const LayoutBuilder_resize_screens_defrant_sizes();
          },
        ));
      } else {
        CustomSnackBar.show(
          context,
          AppLocalizations.of(context).translate('userNameNotFound'),
          backgroundColor: Colors.red,
          textColor: Colors.white,
          icon: Icons.error,
        );
      }
    }
  }

  void navigateToRegister() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegistrationScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context).translate('loginTitle')),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(26),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate('emailLabel'),
                    hintText:
                        AppLocalizations.of(context).translate('emailHint'),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                          .translate('emailError');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate('passwordLabel'),
                    hintText:
                        AppLocalizations.of(context).translate('passwordHint'),
                    border: const OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                          .translate('passwordError');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: CustomButton(
                    text: AppLocalizations.of(context)
                        .translate('letsWorkButton'),
                    onTap: login,
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: AppLocalizations.of(context).translate('createAccount'),
                  onTap: navigateToRegister,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
