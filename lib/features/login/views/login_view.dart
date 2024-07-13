import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import '../../../core/db/login_sql_helper.dart';
import '../../../l10n/app_localizations.dart';
import '../../dashboard/views/main_dashboard_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final iD = TextEditingController();
  String privilege = 'Customer';
  String gender = 'Male';
  final emailController = TextEditingController();
  final branchController = TextEditingController();
  final Sqldb sqldb = Sqldb();
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    users = await sqldb.getUserData();
    setState(() {});
  }

  void saveData() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> user = {
        'username': usernameController.text,
        'birthday': iD.text,
        'privilege': privilege,
        'gender': gender,
        'email': emailController.text,
        'branch': branchController.text,
      };

      await sqldb.insertUser(user);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)
              .translate('loginRecordedSuccessfully'))));
      loadUserData();

      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const DashboardView();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('loginTitle')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(26),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('nameLabel'),
                  hintText: AppLocalizations.of(context).translate('nameHint'),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context).translate('nameError');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: iD,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate('idLabel'),
                  hintText: AppLocalizations.of(context).translate('idHint'),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context).translate('idError');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: privilege,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('privilegeLabel'),
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          privilege = newValue!;
                        });
                      },
                      items: <String>['Admin', 'Customer']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(AppLocalizations.of(context)
                              .translate(value.toLowerCase())),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: gender,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('genderLabel'),
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          gender = newValue!;
                        });
                      },
                      items: <String>['Male', 'Female']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(AppLocalizations.of(context)
                              .translate(value.toLowerCase())),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('emailLabel'),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: branchController,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('branchLabel'),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: CustomButton(
                  text:
                      AppLocalizations.of(context).translate('letsWorkButton'),
                  bgColor: Colors.blueGrey,
                  onTap: saveData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
