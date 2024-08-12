import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pos_dashboard_v1/features/orders/model/order_model.dart';
import 'package:pos_dashboard_v1/features/orders/model/sales_item_model.dart';

class SalesDatabaseHelper {
  static final SalesDatabaseHelper instance = SalesDatabaseHelper._init();
  static Database? _database;

  SalesDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('sales.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    try {
      // Retrieve the APPDATA directory path
      Directory appDocDir = Directory(Platform.environment['APPDATA']!);
      String appDocPath = appDocDir.path;

      // Define the full path for the database file in APPDATA
      String fullPath = join(appDocPath, 'POSdatabases', fileName);

      // Ensure the directory exists
      if (!await Directory(dirname(fullPath)).exists()) {
        await Directory(dirname(fullPath)).create(recursive: true);
      }

      // Open the database at the specified path
      return await openDatabase(
        fullPath,
        version: 1,
        onCreate: _createDB,
        onUpgrade: _onUpgrade,
      );
    } catch (e) {
      throw Exception('Failed to open the database: $e');
    }
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS sales_invoice (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customerName TEXT NOT NULL,
        invoiceDate TEXT NOT NULL,
        invoiceNumber TEXT NOT NULL,
        totalAmount REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS sales_item (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        invoiceId INTEGER NOT NULL,
        name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        unitPrice REAL NOT NULL,
        discount REAL NOT NULL,
        total REAL NOT NULL,
        itemId INTEGER NOT NULL,
        FOREIGN KEY (invoiceId) REFERENCES sales_invoice (id)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await _createDB(db, newVersion);
    }
  }

  Future<void> ensureDbIsInitialized() async {
    final db = await database;
    await _createDB(db, 1);
  }

  static Future<void> deleteInvoice(String invoiceNumber) async {
    final db = await SalesDatabaseHelper.instance.database;
    await db.delete(
      'sales_invoice',
      where: 'invoiceNumber = ?',
      whereArgs: [invoiceNumber],
    );
  }

  Future<List<Order>> getSalesInvoices() async {
    final db = await instance.database;

    final invoices = await db.query('sales_invoice');

    return Future.wait(invoices.map((invoice) async {
      final items = await db.query(
        'sales_item',
        where: 'invoiceId = ?',
        whereArgs: [invoice['id']],
      );

      return Order(
        customerName: invoice['customerName'] as String,
        invoiceDate: invoice['invoiceDate'] as String,
        invoiceNumber: invoice['invoiceNumber'] as String,
        items: items
            .map((item) => SalesItem(
                  item['name'] as String,
                  item['quantity'] as int,
                  item['unitPrice'] as double,
                  item['discount'] as double,
                  item['itemId'] as int,
                ))
            .toList(),
      );
    }));
  }

  Future<int> getSavedBillsCount() async {
    final db = await instance.database;
    final count = await db.query(
      'sales_invoice',
      columns: ['id'],
    );
    return count.length;
  }

  Future<int> insertSalesInvoice(Order invoice) async {
    final db = await instance.database;

    print('Inserting sales invoice'); // Add this line
    final invoiceId = await db.insert('sales_invoice', {
      'customerName': invoice.customerName,
      'invoiceDate': invoice.invoiceDate,
      'invoiceNumber': invoice.invoiceNumber,
      'totalAmount': invoice.items.fold(0.0, (sum, item) => sum = item.total),
    });
    print('Sales invoice inserted with id: $invoiceId'); // Add this line

    for (var item in invoice.items) {
      await db.insert('sales_item', {
        'invoiceId': invoiceId,
        'name': item.name,
        'quantity': item.quantity,
        'unitPrice': item.unitPrice,
        'discount': item.discount,
        'total': item.total,
        'itemId': item.itemID,
      });
    }
    print('Sales items inserted'); // Add this line

    return invoiceId;
  }

  Future<void> createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS sales_invoice (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customerName TEXT NOT NULL,
        invoiceDate TEXT NOT NULL,
        invoiceNumber TEXT NOT NULL,
        totalAmount REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS sales_item (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        invoiceId INTEGER NOT NULL,
        name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        unitPrice REAL NOT NULL,
        discount REAL NOT NULL,
        total REAL NOT NULL,
        itemId INTEGER NOT NULL,
        FOREIGN KEY (invoiceId) REFERENCES sales_invoice (id)
      )
    ''');
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await createDB(db, newVersion);
    }
  }

  Future<List<Order>> getTodayInvoices() async {
    final db = await instance.database;
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final List<Map<String, dynamic>> maps = await db.query(
      'sales_invoice',
      where: "invoiceDate LIKE ?",
      whereArgs: ['$today%'],
    );

    print('Number of invoices created today: ${maps.length}');

    return Future.wait(maps.map((invoice) async {
      final items = await db.query(
        'sales_item',
        where: 'invoiceId = ?',
        whereArgs: [invoice['id']],
      );

      return Order(
        customerName: invoice['customerName'] as String,
        invoiceDate: invoice['invoiceDate'] as String,
        invoiceNumber: invoice['invoiceNumber'] as String,
        items: items
            .map((item) => SalesItem(
                  item['name'] as String,
                  item['quantity'] as int,
                  item['unitPrice'] as double,
                  item['discount'] as double,
                  item['itemId'] as int,
                ))
            .toList(),
      );
    }).toList());
  }

  Future<List<Order>> getInvoicesByDay(String day) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'sales_invoice',
      where: "invoiceDate LIKE ?",
      whereArgs: ['$day%'],
    );

    print(
        '============= Number of invoices created on $day: ${maps.length} ======================');

    return Future.wait(maps.map((invoice) async {
      final items = await db.query(
        'sales_item',
        where: 'invoiceId = ?',
        whereArgs: [invoice['id']],
      );

      return Order(
        customerName: invoice['customerName'] as String,
        invoiceDate: invoice['invoiceDate'] as String,
        invoiceNumber: invoice['invoiceNumber'] as String,
        items: items
            .map((item) => SalesItem(
                  item['name'] as String,
                  item['quantity'] as int,
                  item['unitPrice'] as double,
                  item['discount'] as double,
                  item['itemId'] as int,
                ))
            .toList(),
      );
    }).toList());
  }

  Future<int> getTodayInvoicesCount() async {
    final db = await instance.database;
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final List<Map<String, dynamic>> maps = await db.query(
      'sales_invoice',
      where: "invoiceDate LIKE ?",
      whereArgs: ['$today%'],
    );

    print(
        '============= Number of invoices created today: ${maps.length} ======================');
    return maps.length;
  }
}
