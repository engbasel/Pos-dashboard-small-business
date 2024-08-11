import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';
import 'package:sqflite/sqflite.dart';
import 'database_constans.dart';

class DatabaseReturnsInvoice {
  static final DatabaseReturnsInvoice _instance =
      DatabaseReturnsInvoice._internal();
  factory DatabaseReturnsInvoice() => _instance;
  DatabaseReturnsInvoice._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // String path = join(
    //   await getDatabasesPath(),
    //   RetuernInvocmentDatabaseConstants.databaseFileName,
    // );

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
      version: RetuernInvocmentDatabaseConstants.versionDatabase,
    );
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
    print(
        '============= database created with file name ${RetuernInvocmentDatabaseConstants.databaseFileName}======================');

    print('''
Created with columns names is :
    ${RetuernInvocmentDatabaseConstants.columnId}, ${RetuernInvocmentDatabaseConstants.columnOrderId},${RetuernInvocmentDatabaseConstants.columnReturnDate}, ${RetuernInvocmentDatabaseConstants.columnEmployee},  ${RetuernInvocmentDatabaseConstants.columnReason}, ${RetuernInvocmentDatabaseConstants.columnAmount},   ${RetuernInvocmentDatabaseConstants.columnTotalBackMoney} ,
''');
  }

  Future<void> insertReturnInvoice(ReturnInvoiceModel returnInvoice) async {
    final db = await database;
    await db.insert(
      RetuernInvocmentDatabaseConstants.returnInvoicesTable,
      returnInvoice.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(
        '''============= insert Invoice item in table name:${RetuernInvocmentDatabaseConstants.returnInvoicesTable},======== with data is ${returnInvoice.toMap()}, ============== ''');
  }

  Future<void> deleteReturnInvoice(String id) async {
    final db = await database;
    await db.delete(
      RetuernInvocmentDatabaseConstants.returnInvoicesTable,
      where: '${RetuernInvocmentDatabaseConstants.columnId} = ?',
      whereArgs: [id],
    );
    print(
        '============= deleted Invoice item ${RetuernInvocmentDatabaseConstants.columnId} from database table :  ${RetuernInvocmentDatabaseConstants.returnInvoicesTable} ======================');
  }

  Future<void> updateReturnInvoice(ReturnInvoiceModel returnInvoice) async {
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

  Future<List<ReturnInvoiceModel>> getReturnInvoices() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(RetuernInvocmentDatabaseConstants.returnInvoicesTable);
    return List.generate(maps.length, (i) {
      return ReturnInvoiceModel.fromMap(maps[i]);
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

    print(
        '================updated database table Name:  $tableName ===========================');
    debugPrint(
        "=================================== $data      ======================");
  }

  // Method to get the number of invoices created today
  Future<int> getTodayInvoicesCount() async {
    final db = await database;
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final List<Map<String, dynamic>> maps = await db.query(
      RetuernInvocmentDatabaseConstants.returnInvoicesTable,
      where: "${RetuernInvocmentDatabaseConstants.columnReturnDate} LIKE ?",
      whereArgs: ['$today%'],
    );

    print(
        '============= Number of invoices created today: ${maps.length} ======================');
    return maps.length;
  }

  // Method to get invoices by a specific day
  Future<List<ReturnInvoiceModel>> getInvoicesByDay(String day) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      RetuernInvocmentDatabaseConstants.returnInvoicesTable,
      where: "${RetuernInvocmentDatabaseConstants.columnReturnDate} LIKE ?",
      whereArgs: ['$day%'],
    );

    print(
        '============= Number of invoices created on $day: ${maps.length} ======================');

    return List.generate(maps.length, (i) {
      return ReturnInvoiceModel.fromMap(maps[i]);
    });
  }

  // Method to get invoices created today
  Future<List<ReturnInvoiceModel>> getTodayInvoices() async {
    final db = await database;
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final List<Map<String, dynamic>> maps = await db.query(
      RetuernInvocmentDatabaseConstants.returnInvoicesTable,
      where: "${RetuernInvocmentDatabaseConstants.columnReturnDate} LIKE ?",
      whereArgs: ['$today%'],
    );

    print(
        '============= Number of invoices created today: ${maps.length} ======================');

    return List.generate(maps.length, (i) {
      return ReturnInvoiceModel.fromMap(maps[i]);
    });
  }
}
