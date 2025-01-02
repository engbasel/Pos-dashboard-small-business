import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/Manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/core/widgets/layout_builder_resize_screens_differant_sizes.dart';
import 'package:pos_dashboard_v1/features/authentication/database/auth_service.dart';
import 'package:pos_dashboard_v1/features/authentication/views/signup_accounts.dart';
import '../../../core/widgets/custom_snackbar.dart';
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
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
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
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/shop.png',
                      height: 150,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('emailLabel'),
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
                          return AppLocalizations.of(context)
                              .translate('passwordError');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: AppLocalizations.of(context)
                          .translate('letsWorkButton'),
                      onTap: login,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate('dontHaveAccountText'),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: navigateToRegister,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: ColorsManager
                                  .kPrimaryColor, // Button background color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Ensure the button has the same rounded corners
                              ),
                            ),
                            onPressed: navigateToRegister,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('createAccount'),
                              style: const TextStyle(
                                color:
                                    ColorsManager.headerTextColor, // Text color
                                fontSize: 14, // Adjusted font size
                                fontWeight: FontWeight.w500, // Font weight
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
