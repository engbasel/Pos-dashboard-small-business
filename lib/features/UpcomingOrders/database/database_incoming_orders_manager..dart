import 'dart:async';
import 'package:path/path.dart';
import 'package:pos_dashboard_v1/features/UpcomingOrders/model/incoming_order_model.dart';
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
    String path = join(await getDatabasesPath(),
        IncomingOrderDatabaseConstants.databaseFileName);
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
}
