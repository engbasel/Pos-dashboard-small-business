import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/models/order_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  static const String _databaseName = 'orders_database.db';
  static const int _databaseVersion = 2;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> addCategoryColumn() async {
    final db = await database;
    var columns = await db.rawQuery('PRAGMA table_info(orders)');
    if (!columns.any((column) => column['name'] == 'category')) {
      await _addCategoryColumn(db);
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders(
        id TEXT PRIMARY KEY,
        dateTime TEXT,
        type TEXT,
        employee TEXT,
        status TEXT,
        paymentStatus TEXT,
        amount REAL,
        numberOfItems INTEGER,
        entryDate TEXT,
        exitDate TEXT,
        wholesalePrice REAL,
        retailPrice REAL,
        productStatus TEXT,
        productDetails TEXT,
        productModel TEXT,
        category TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _addCategoryColumn(db);
    }
  }

  Future<void> _addCategoryColumn(Database db) async {
    await db.execute('ALTER TABLE orders ADD COLUMN category TEXT');
  }

  Future<List<Order>> getOrders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('orders');
    return List.generate(maps.length, (i) => Order.fromMap(maps[i]));
  }

  Future<void> insertOrder(Order order) async {
    final db = await database;
    await db.insert(
      'orders',
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateOrder(Order order) async {
    final db = await database;
    await db.update(
      'orders',
      order.toMap(),
      where: 'id = ?',
      whereArgs: [order.id],
    );
  }

  Future<void> deleteOrder(String id) async {
    final db = await database;
    await db.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
