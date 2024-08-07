import 'package:pos_dashboard_v1/features/authentication/database/accounts_db_helper.dart';

class Account {
  int? id;
  String? name;
  String email;
  String password;
  String phone;
  int isAdmin;
  int isVerified;
  int isDeleted;

  Account({
    this.id,
    this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.isAdmin,
    required this.isVerified,
    required this.isDeleted,
  });

  // Convert a Account object into a Map object
  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.columnId: id,
      DatabaseConstants.columnName: name,
      DatabaseConstants.columnEmail: email,
      DatabaseConstants.columnPassword: password,
      DatabaseConstants.columnPhone: phone,
      DatabaseConstants.columnIsAdmin: isAdmin,
      DatabaseConstants.columnIsVerified: isVerified,
      DatabaseConstants.columnIsDeleted: isDeleted,
    };
  }

  // Extract a Account object from a Map object
  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map[DatabaseConstants.columnId],
      name: map[DatabaseConstants.columnName],
      email: map[DatabaseConstants.columnEmail],
      password: map[DatabaseConstants.columnPassword],
      phone: map[DatabaseConstants.columnPhone],
      isAdmin: map[DatabaseConstants.columnIsAdmin],
      isVerified: map[DatabaseConstants.columnIsVerified],
      isDeleted: map[DatabaseConstants.columnIsDeleted],
    );
  }
}
