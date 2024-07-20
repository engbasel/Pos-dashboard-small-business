import 'dart:async';
import 'package:path/path.dart';
import 'package:pos_dashboard_v1/features/RetuernsInvoices/models/ReturnInvoice_model.dart';
import 'package:sqflite/sqflite.dart';
import 'database_constans.dart';

class database_Returnsinvoice {
  static final database_Returnsinvoice _instance =
      database_Returnsinvoice._internal();
  factory database_Returnsinvoice() => _instance;
  database_Returnsinvoice._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'returnsNeww_database.db');
    return await openDatabase(
      path,
      onCreate: onCreate,
      version: 3,
    );
  }

  Future<void> updateReturnInvoice(ReturnInvoice returnInvoice) async {
    final db = await database;
    await db.update(
      RetuernInvocmentDatabaseConstants.returnInvoicesTable,
      returnInvoice.toMap(),
      where: '${RetuernInvocmentDatabaseConstants.columnId} = ?',
      whereArgs: [returnInvoice.id],
    );
    print('============= updated Return Invoice ======================');
    print(returnInvoice.toMap());
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(
      '''
    CREATE TABLE ${RetuernInvocmentDatabaseConstants.returnInvoicesTable} (
      ${RetuernInvocmentDatabaseConstants.columnId} TEXT PRIMARY KEY,
      ${RetuernInvocmentDatabaseConstants.columnOrderId} TEXT,
      ${RetuernInvocmentDatabaseConstants.columnReturnDate} TEXT,
      ${RetuernInvocmentDatabaseConstants.columnEmployee} TEXT,
      ${RetuernInvocmentDatabaseConstants.columnReason} TEXT,
      ${RetuernInvocmentDatabaseConstants.columnAmount} REAL,
      ${RetuernInvocmentDatabaseConstants.columnTotalBackMoney} REAL
    )
    ''',
    );
    print('============= database created ======================');
  }

  Future<void> insertReturnInvoice(ReturnInvoice returnInvoice) async {
    final db = await database;
    await db.insert(
      RetuernInvocmentDatabaseConstants.returnInvoicesTable,
      returnInvoice.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('============= insert Invoice======================');
  }

  Future<void> deleteReturnInvoice(String id) async {
    final db = await database;
    await db.delete(
      RetuernInvocmentDatabaseConstants.returnInvoicesTable,
      where: '${RetuernInvocmentDatabaseConstants.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<List<ReturnInvoice>> getReturnInvoices() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(RetuernInvocmentDatabaseConstants.returnInvoicesTable);
    return List.generate(maps.length, (i) {
      return ReturnInvoice.fromMap(maps[i]);
    });
  }

  Future<void> updateData(String tableName, Map<String, dynamic> data,
      String idColumn, String id) async {
    final db = await database;
    await db.update(
      tableName,
      data,
      where: '$idColumn = ?',
      whereArgs: [id],
    );

    print('================updated $tableName ===========================');
    print(data);
  }
}
