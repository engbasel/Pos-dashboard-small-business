import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/features/authentication/database/auth_service.dart';
import 'package:pos_dashboard_v1/features/authentication/views/signup_accounts.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../../core/widgets/layout_builder_resize_screens_differant_sizes.dart';
import '../../../l10n/app_localizations.dart';
import 'package:pos_dashboard_v1/features/authentication/models/account_model.dart';

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
        title: Text(
          AppLocalizations.of(context).translate('loginTitle'),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .2),
            Image.asset(
              'assets/images/shop.png',
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('emailLabel'),
                      hintText: AppLocalizations.of(context)
                          .translate('user@company.domain'),
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
                          AppLocalizations.of(context).translate('Password'),
                      hintText:
                          AppLocalizations.of(context).translate('********'),
                      border: const OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        CustomSnackBar.show(
                          context,
                          AppLocalizations.of(context)
                              .translate('passoword_or_email_is_empty'),
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          icon: Icons.error,
                        );
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomButton(
                          text: AppLocalizations.of(context)
                              .translate('letsWorkButton'),
                          onTap: login,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomButton(
                          text: AppLocalizations.of(context)
                              .translate('createAccount'),
                          onTap: navigateToRegister,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
