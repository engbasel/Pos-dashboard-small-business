import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import '../../../../core/db/Log_file_database_helper.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../core/widgets/layout_builder_resize_screens_differant_sizes.dart';
import '../../../../l10n/app_localizations.dart';

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
      DateTime now = DateTime.now();
      String currentDate = "${now.year}-${now.month}-${now.day}";
      String currentTime = "${now.hour}:${now.minute}:${now.second}";

      Map<String, dynamic> user = {
        'username': usernameController.text,
        'birthday': iD.text,
        'privilege': privilege,
        'gender': gender,
        'email': emailController.text,
        'branch': branchController.text,
        'createdAt': currentDate,
        'createdTime': currentTime,
      };

      await sqldb.insertUser(user);

      CustomSnackBar.show(
        context,
        AppLocalizations.of(context).translate('loginRecordedSuccessfully'),
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        icon: Icons.info,
      );
      loadUserData();

      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const LayoutBuilder_resize_screens_defrant_sizes();
        },
      ));
    } else {
      CustomSnackBar.show(
          context, AppLocalizations.of(context).translate('userNameNotFound'));
    }
  }

  // void saveData() async {
  //   if (_formKey.currentState!.validate()) {
  //     Map<String, dynamic> user = {
  //       'username': usernameController.text,
  //       'birthday': iD.text,
  //       'privilege': privilege,
  //       'gender': gender,
  //       'email': emailController.text,
  //       'branch': branchController.text,
  //     };

  //     await sqldb.insertUser(user);

  //     CustomSnackBar.show(
  //       context,
  //       AppLocalizations.of(context).translate('loginRecordedSuccessfully'),
  //       backgroundColor: Colors.blue,
  //       textColor: Colors.white,
  //       icon: Icons.info,
  //     );
  //     loadUserData();

  //     Navigator.push(context, MaterialPageRoute(
  //       builder: (context) {
  //         return const LayoutBuilder_resize_screens_defrant_sizes();
  //       },
  //     ));
  //   } else {
  //     CustomSnackBar.show(
  //         context, AppLocalizations.of(context).translate('userNameNotFound'));
  //   }
  // }

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
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate('nameLabel'),
                    hintText:
                        AppLocalizations.of(context).translate('nameHint'),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                          .translate('nameError');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: iD,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate('Password'),
                    hintText:
                        AppLocalizations.of(context).translate('Password'),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                          .translate('InvalidPassword');
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
                    onTap: saveData,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
