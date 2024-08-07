import 'package:pos_dashboard_v1/features/authentication/create_account/database/accounts_db_helper.dart';
import 'package:pos_dashboard_v1/features/authentication/create_account/models/createAccounts.dart';

class AuthService {
  final CreateacountesDatabase _dbHelper = CreateacountesDatabase();

  Future<Account?> login(String email, String password) async {
    return await _dbHelper.authenticate(email, password);
  }

  Future<int> register(Account account) async {
    return await _dbHelper.insertAccount(account);
  }

  Future<List<Account>> getAllAccounts() async {
    return await _dbHelper.getAllAccounts();
  }
}
