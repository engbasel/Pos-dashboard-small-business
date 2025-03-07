import 'package:pos_dashboard_v1/features/authentication/database/accounts_db_helper.dart';
import 'package:pos_dashboard_v1/features/authentication/models/account_model.dart';

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
