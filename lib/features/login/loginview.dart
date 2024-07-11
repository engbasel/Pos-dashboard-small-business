import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/login/sql.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final birthdayController = TextEditingController();
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
        'birthday': birthdayController.text,
        'privilege': privilege,
        'gender': gender,
        'email': emailController.text,
        'branch': branchController.text,
      };

      await sqldb.insertUser(user);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data saved successfully')));
      loadUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                    TextFormField(
                      controller: birthdayController,
                      decoration: const InputDecoration(labelText: 'Birthday'),
                    ),
                    DropdownButtonFormField<String>(
                      value: privilege,
                      decoration: const InputDecoration(labelText: 'Privilege'),
                      onChanged: (newValue) {
                        setState(() {
                          privilege = newValue!;
                        });
                      },
                      items: <String>['Admin', 'Customer']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    DropdownButtonFormField<String>(
                      value: gender,
                      decoration: const InputDecoration(labelText: 'Gender'),
                      onChanged: (newValue) {
                        setState(() {
                          gender = newValue!;
                        });
                      },
                      items: <String>['Male', 'Female']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      controller: branchController,
                      decoration: const InputDecoration(labelText: 'Branch'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        saveData();
                      },
                      child: const Text('Save'),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title:
                                Text('Username: ${users[index]['username']}'),
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
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
