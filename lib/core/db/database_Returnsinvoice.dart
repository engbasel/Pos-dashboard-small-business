import 'dart:async';
import 'package:path/path.dart';
import 'package:pos_dashboard_v1/core/utils/models/ReturnInvoice_model.dart';
import 'package:sqflite/sqflite.dart';

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
    String path = join(await getDatabasesPath(), 'returns_database.db');
    return await openDatabase(
      path,
      onCreate: onCreate,
      version: 1,
    );
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE return_invoices(
        id TEXT PRIMARY KEY,
        orderId TEXT,
        returnDate TEXT,
        employee TEXT,
        reason TEXT,
        amount REAL
      )
      ''',
    );
  }

  Future<void> insertReturnInvoice(ReturnInvoice returnInvoice) async {
    final db = await database;
    await db.insert(
      'return_invoices',
      returnInvoice.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateReturnInvoice(ReturnInvoice returnInvoice) async {
    final db = await database;
    await db.update(
      'return_invoices',
      returnInvoice.toMap(),
      where: 'id = ?',
      whereArgs: [returnInvoice.id],
    );
  }

  Future<void> deleteReturnInvoice(String id) async {
    final db = await database;
    await db.delete(
      'return_invoices',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ReturnInvoice>> getReturnInvoices() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('return_invoices');
    return List.generate(maps.length, (i) {
      return ReturnInvoice.fromMap(maps[i]);
    });
  }
}
