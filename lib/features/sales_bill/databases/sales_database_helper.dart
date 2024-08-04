import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pos_dashboard_v1/features/sales_bill/model/sales_invoice.dart';
import 'package:pos_dashboard_v1/features/sales_bill/model/sales_item_model.dart';

class SalesDatabaseHelper {
  static final SalesDatabaseHelper instance = SalesDatabaseHelper._init();
  static Database? _database;

  SalesDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('sales.db');
    return _database!;
  }

  Future<void> ensureDbIsInitialized() async {
    final db = await database;
    await createDB(db, 1);
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: createDB,
      onUpgrade: onUpgrade,
    );
  }

  static Future<void> deleteInvoice(String invoiceNumber) async {
    final db = await SalesDatabaseHelper.instance.database;
    await db.delete(
      'sales_invoice',
      where: 'invoiceNumber = ?',
      whereArgs: [invoiceNumber],
    );
  }

  Future<List<SalesInvoice>> getSalesInvoices() async {
    final db = await instance.database;

    final invoices = await db.query('sales_invoice');

    return Future.wait(invoices.map((invoice) async {
      final items = await db.query(
        'sales_item',
        where: 'invoiceId = ?',
        whereArgs: [invoice['id']],
      );

      return SalesInvoice(
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

  Future<int> insertSalesInvoice(SalesInvoice invoice) async {
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
}
