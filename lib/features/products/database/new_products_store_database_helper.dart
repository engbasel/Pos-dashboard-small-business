import 'dart:io';

import 'package:path/path.dart';
import 'package:pos_dashboard_v1/features/categories/database/category_database_constants.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_constants.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/utils/models/order_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  static const String _databaseName = 'orders_database.db';
  static const int _databaseVersion = 2;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // String path = join(await getDatabasesPath(), _databaseName);
    Directory appDocDir = Directory(Platform.environment['APPDATA']!);
    String appDocPath = appDocDir.path;
    String path = join(appDocPath, 'POSdatabases', _databaseName);

    if (!await Directory(join(appDocPath, 'POSdatabases')).exists()) {
      await Directory(join(appDocPath, 'POSdatabases')).create(recursive: true);
    }

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
  }

  Future<void> addCategoryColumn() async {
    final db = await database;
    var columns = await db.rawQuery('PRAGMA table_info(orders)');
    if (!columns.any((column) => column['name'] == 'category')) {
      await _addCategoryColumn(db);
    }
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${ItemDatabaseConstants.itemsTable} (
        ${ItemDatabaseConstants.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${ItemDatabaseConstants.columnCategoryId} INTEGER,
        ${ItemDatabaseConstants.columnName} TEXT NOT NULL,
        ${ItemDatabaseConstants.columnDescription} TEXT,
        ${ItemDatabaseConstants.columnSKU} TEXT,
        ${ItemDatabaseConstants.columnBarcode} TEXT,
        ${ItemDatabaseConstants.columnPurchasePrice} REAL,
        ${ItemDatabaseConstants.columnSalePrice} REAL,
        ${ItemDatabaseConstants.columnWholesalePrice} REAL,
        ${ItemDatabaseConstants.columnTaxRate} REAL,
        ${ItemDatabaseConstants.columnQuantity} INTEGER,
        ${ItemDatabaseConstants.columnAlertQuantity} INTEGER,
        ${ItemDatabaseConstants.columnImage} TEXT,
        ${ItemDatabaseConstants.columnBrand} TEXT,
        ${ItemDatabaseConstants.columnSize} TEXT,
        ${ItemDatabaseConstants.columnWeight} REAL,
        ${ItemDatabaseConstants.columnColor} TEXT,
        ${ItemDatabaseConstants.columnMaterial} TEXT,
        ${ItemDatabaseConstants.columnWarranty} TEXT,
        ${ItemDatabaseConstants.columnSupplierId} INTEGER,
        ${ItemDatabaseConstants.columnItemStatus} TEXT CHECK (${ItemDatabaseConstants.columnItemStatus} IN ('active', 'inactive', 'discontinued')),
        ${ItemDatabaseConstants.columnDateAdded} TEXT,
        ${ItemDatabaseConstants.columnDateModified} TEXT,
        FOREIGN KEY (${ItemDatabaseConstants.columnCategoryId}) REFERENCES categories (${CategoryDatabaseConstants.columnId}),
        FOREIGN KEY (${ItemDatabaseConstants.columnSupplierId}) REFERENCES suppliers (supplierId)
      )
    ''');
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _addCategoryColumn(db);
    }
  }

  Future<void> _addCategoryColumn(Database db) async {
    await db.execute('ALTER TABLE orders ADD COLUMN category TEXT');
  }

  Future<void> insertOrderAndItem(Order order, ItemModel item) async {
    final db = await database;
    await db.transaction((txn) async {
      // Insert the order
      await txn.insert(
        'orders',
        order.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Insert the item
      await txn.insert(
        ItemDatabaseConstants.itemsTable,
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
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
