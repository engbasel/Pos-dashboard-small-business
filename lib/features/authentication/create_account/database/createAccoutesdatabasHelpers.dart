import 'package:pos_dashboard_v1/features/authentication/create_account/models/createAccounts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

class CreateacountesDatabase {
  static final CreateacountesDatabase _instance =
      CreateacountesDatabase._internal();
  factory CreateacountesDatabase() => _instance;

  static Database? _database;

  CreateacountesDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path =
        join(await getDatabasesPath(), DatabaseConstants.databaseName);
    print("Initializing database at: $path");
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  Future<List<Account>> getAllAccounts() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      DatabaseConstants.tableName,
      where: '${DatabaseConstants.columnIsDeleted} = 0',
    );

    print("Fetched ${maps.length} accounts");
    return List.generate(maps.length, (i) {
      return Account.fromMap(maps[i]);
    });
  }

  Future onCreate(Database db, int version) async {
    print("Creating table: ${DatabaseConstants.tableName}");
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableName} (
        ${DatabaseConstants.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseConstants.columnName} TEXT,
        ${DatabaseConstants.columnEmail} TEXT NOT NULL,
        ${DatabaseConstants.columnPassword} TEXT NOT NULL,
        ${DatabaseConstants.columnPhone} TEXT,
        ${DatabaseConstants.columnIsAdmin} INTEGER NOT NULL,
        ${DatabaseConstants.columnIsVerified} INTEGER NOT NULL,
        ${DatabaseConstants.columnIsDeleted} INTEGER NOT NULL
      )
    ''');
  }

  // Insert a new account
  Future<int> insertAccount(Account account) async {
    final db = await database;
    int result = await db.insert(DatabaseConstants.tableName, account.toMap());
    print("Inserted account: ${account.toMap()} with result: $result");
    return result;
  }

  // Get account by email and password for authentication
  Future<Account?> authenticate(String email, String password) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      DatabaseConstants.tableName,
      where:
          '${DatabaseConstants.columnEmail} = ? AND ${DatabaseConstants.columnPassword} = ? AND ${DatabaseConstants.columnIsDeleted} = 0',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      print("Authenticated user with email: $email");
      return Account.fromMap(maps.first);
    }
    print("Failed to authenticate user with email: $email");
    return null;
  }

  // Other CRUD operations can be added here
}

class DatabaseConstants {
  static const String databaseName = 'app_database.db';
  static const String tableName = 'accounts';

  // Column names
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnEmail = 'email';
  static const String columnPassword = 'password';
  static const String columnPhone = 'phone';
  static const String columnIsAdmin = 'isAdmin';
  static const String columnIsVerified = 'isVerified';
  static const String columnIsDeleted = 'isDeleted';
}
