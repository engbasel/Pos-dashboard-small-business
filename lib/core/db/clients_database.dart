import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// ignore: camel_case_types
class Customers_helper {
  static Database? _database;
  static const String dbName = 'customers.db';
  static const String tableName = 'customers';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  void _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT,
        indebtedness TEXT,
        currentAccount TEXT,
        notes TEXT
      )
    ''');
  }

  Future<void> insertCustomer(Map<String, String> customer) async {
    Database db = await database;
    await db.insert(tableName, customer);
  }

  Future<void> updateCustomer(Map<String, String> customer) async {
    Database db = await database;
    await db.update(tableName, customer,
        where: 'id = ?', whereArgs: [customer['id']]);
  }

  Future<void> deleteCustomer(int id) async {
    Database db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getCustomers() async {
    Database db = await database;
    return await db.query(tableName);
  }

  Future<void> close() async {
    Database db = await database;
    db.close();
  }
}
