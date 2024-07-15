import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class StaffDatabaseHelper {
  static final StaffDatabaseHelper _instance = StaffDatabaseHelper.internal();
  factory StaffDatabaseHelper() => _instance;
  StaffDatabaseHelper.internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'staff.db');
    return await openDatabase(
      path,
      version: 2, // Increment the version number
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE staff(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        midName TEXT,
        lastName TEXT,
        position TEXT,
        qualifications TEXT,
        department TEXT,
        city TEXT,
        experienceInPosition TEXT,
        salary REAL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add new columns in version 2
      await _addColumnIfNotExists(db, 'staff', 'firstName', 'TEXT');
      await _addColumnIfNotExists(db, 'staff', 'midName', 'TEXT');
      await _addColumnIfNotExists(db, 'staff', 'lastName', 'TEXT');
      await _addColumnIfNotExists(db, 'staff', 'position', 'TEXT');
      await _addColumnIfNotExists(db, 'staff', 'qualifications', 'TEXT');
      await _addColumnIfNotExists(db, 'staff', 'department', 'TEXT');
      await _addColumnIfNotExists(db, 'staff', 'city', 'TEXT');
      await _addColumnIfNotExists(db, 'staff', 'experienceInPosition', 'TEXT');
      await _addColumnIfNotExists(db, 'staff', 'salary', 'REAL');
    }
  }

  Future<void> _addColumnIfNotExists(Database db, String tableName,
      String columnName, String columnType) async {
    var tableInfo = await db.rawQuery('PRAGMA table_info($tableName)');
    var columnExists = tableInfo.any((column) => column['name'] == columnName);

    if (!columnExists) {
      await db
          .execute('ALTER TABLE $tableName ADD COLUMN $columnName $columnType');
    }
  }

  Future<int> saveStaff(Map<String, dynamic> staff) async {
    var dbClient = await db;
    return await dbClient.insert('staff', staff);
  }

  Future<List<Map<String, dynamic>>> getStaff() async {
    var dbClient = await db;
    return await dbClient.query('staff');
  }

  Future<int> deleteStaff(int id) async {
    var dbClient = await db;
    return await dbClient.delete('staff', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateStaff(Map<String, dynamic> staff) async {
    var dbClient = await db;
    return await dbClient
        .update('staff', staff, where: 'id = ?', whereArgs: [staff['id']]);
  }
}
