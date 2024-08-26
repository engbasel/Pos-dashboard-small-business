import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/database/database_constans.dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/model/incoming_order_model.dart';
import 'package:sqflite/sqflite.dart';
import 'incoming_order_database_constants.dart';

class DatabaseIncomingOrdersManager {
  static final DatabaseIncomingOrdersManager _instance =
      DatabaseIncomingOrdersManager._internal();
  factory DatabaseIncomingOrdersManager() => _instance;
  DatabaseIncomingOrdersManager._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // String path = join(await getDatabasesPath(),
    //     IncomingOrderDatabaseConstants.databaseFileName);

    Directory appDocDir = Directory(Platform.environment['APPDATA']!);
    String appDocPath = appDocDir.path;
    String path = join(appDocPath, 'POSdatabases',
        RetuernInvocmentDatabaseConstants.databaseFileName);

    if (!await Directory(join(appDocPath, 'POSdatabases')).exists()) {
      await Directory(join(appDocPath, 'POSdatabases')).create(recursive: true);
    }
    return await openDatabase(
      path,
      onCreate: onCreate,
      version: IncomingOrderDatabaseConstants.versionDatabase,
    );
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE ${IncomingOrderDatabaseConstants.incomingOrdersTable} (
        ${IncomingOrderDatabaseConstants.columnId} TEXT PRIMARY KEY,
        ${IncomingOrderDatabaseConstants.columnOrderId} TEXT,
        ${IncomingOrderDatabaseConstants.columnSupplierName} TEXT,
        ${IncomingOrderDatabaseConstants.columnOrderDate} TEXT,
        ${IncomingOrderDatabaseConstants.columnExpectedDeliveryDate} TEXT,
        ${IncomingOrderDatabaseConstants.columnOrderStatus} TEXT,
        ${IncomingOrderDatabaseConstants.columnTotalAmount} REAL
      )
      ''',
    );
    print(
        'Database created with file name ${IncomingOrderDatabaseConstants.databaseFileName}');
  }

  Future<void> insertIncomingOrder(IncomingOrderModel incomingOrder) async {
    final db = await database;
    await db.insert(
      IncomingOrderDatabaseConstants.incomingOrdersTable,
      incomingOrder.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(
        'Inserted order in table ${IncomingOrderDatabaseConstants.incomingOrdersTable} with data ${incomingOrder.toMap()}');
  }

  Future<void> updateIncomingOrder(IncomingOrderModel incomingOrder) async {
    final db = await database;
    await db.update(
      IncomingOrderDatabaseConstants.incomingOrdersTable,
      incomingOrder.toMap(),
      where: '${IncomingOrderDatabaseConstants.columnId} = ?',
      whereArgs: [incomingOrder.id],
    );
    print('Updated order with data ${incomingOrder.toMap()}');
  }

  Future<void> deleteIncomingOrder(String id) async {
    final db = await database;
    await db.delete(
      IncomingOrderDatabaseConstants.incomingOrdersTable,
      where: '${IncomingOrderDatabaseConstants.columnId} = ?',
      whereArgs: [id],
    );
    print(
        'Deleted order with ID $id from table ${IncomingOrderDatabaseConstants.incomingOrdersTable}');
  }

  Future<List<IncomingOrderModel>> getIncomingOrders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(IncomingOrderDatabaseConstants.incomingOrdersTable);
    return List.generate(maps.length, (i) {
      return IncomingOrderModel.fromMap(maps[i]);
    });
  }

  // Method to get incoming orders by a specific day
  Future<List<IncomingOrderModel>> getOrdersByDay(String day) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      IncomingOrderDatabaseConstants.incomingOrdersTable,
      where: "${IncomingOrderDatabaseConstants.columnOrderDate} LIKE ?",
      whereArgs: ['$day%'],
    );

    print(
        '============= Number of orders created on $day: ${maps.length} ======================');

    return List.generate(maps.length, (i) {
      return IncomingOrderModel.fromMap(maps[i]);
    });
  }

  // Method to get incoming orders by a specific month
  Future<List<IncomingOrderModel>> getOrdersByMonth(String month) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      IncomingOrderDatabaseConstants.incomingOrdersTable,
      where: "${IncomingOrderDatabaseConstants.columnOrderDate} LIKE ?",
      whereArgs: ['$month%'],
    );

    print(
        '============= Number of orders created in $month: ${maps.length} ======================');

    return List.generate(maps.length, (i) {
      return IncomingOrderModel.fromMap(maps[i]);
    });
  }

  // Method to get incoming orders by a specific year
  Future<List<IncomingOrderModel>> getOrdersByYear(String year) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      IncomingOrderDatabaseConstants.incomingOrdersTable,
      where: "${IncomingOrderDatabaseConstants.columnOrderDate} LIKE ?",
      whereArgs: ['$year%'],
    );

    print(
        '============= Number of orders created in $year: ${maps.length} ======================');

    return List.generate(maps.length, (i) {
      return IncomingOrderModel.fromMap(maps[i]);
    });
  }

  // Method to get incoming orders created today
  Future<List<IncomingOrderModel>> getTodayOrders() async {
    final db = await database;
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final List<Map<String, dynamic>> maps = await db.query(
      IncomingOrderDatabaseConstants.incomingOrdersTable,
      where: "${IncomingOrderDatabaseConstants.columnOrderDate} LIKE ?",
      whereArgs: ['$today%'],
    );

    print(
        '============= Number of orders created today: ${maps.length} ======================');

    return List.generate(maps.length, (i) {
      return IncomingOrderModel.fromMap(maps[i]);
    });
  }

  // Method to get incoming orders by a specific range of dates
  Future<List<IncomingOrderModel>> getOrdersByDateRange(
      String startDate, String endDate) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      IncomingOrderDatabaseConstants.incomingOrdersTable,
      where:
          "${IncomingOrderDatabaseConstants.columnOrderDate} BETWEEN ? AND ?",
      whereArgs: [startDate, endDate],
    );

    print(
        '============= Number of orders between $startDate and $endDate: ${maps.length} ======================');

    return List.generate(maps.length, (i) {
      return IncomingOrderModel.fromMap(maps[i]);
    });
  }
}
