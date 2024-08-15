import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'constantsCustomersHelper.dart'; // Import the constants

// ignore: camel_case_types
class CustomersHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    Directory appDocDir = Directory(Platform.environment['APPDATA']!);
    String appDocPath = appDocDir.path;
    String path = join(appDocPath, dbPathFolderName, dbName);

    if (!await Directory(join(appDocPath, dbPathFolderName)).exists()) {
      await Directory(join(appDocPath, dbPathFolderName))
          .create(recursive: true);
    }

    return await openDatabase(path, version: 1, onCreate: createDatabase);
  }

  void createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT,
        $columnPhoneNumber TEXT,
        $columnEmail TEXT,
        $columnAddress TEXT,
        $columnCreationDate TEXT,
        $columnNotes TEXT,
        $columnBalance REAL,
        $columnLastTransactionDate TEXT,
        $columnBirthDate TEXT,
        $columnGender TEXT,
        $columnOccupation TEXT,
        $columnStatus TEXT,
        $columnAlternativePhone TEXT,
        $columnSocialMedia TEXT,
        $columnFax TEXT,
        $columnCreditLimit REAL,
        $columnTotalOutstandingAmount REAL,
        $columnCreditRating TEXT,
        $columnPreferredPaymentMethod TEXT,
        $columnSecondaryAddress TEXT,
        $columnPostalCode TEXT,
        $columnDeliveryPreferences TEXT,
        $columnLastContactDate TEXT,
        $columnCustomerInterests TEXT,
        $columnCustomerSatisfactionLevel TEXT,
        $columnAnnualPurchaseVolume REAL,
        $columnComplaintCount INTEGER,
        $columnComplaintResolutionHistory TEXT,
        $columnSupportRating TEXT,
        $columnCustomerDiscount REAL,
        $columnActiveOffers TEXT,
        $columnDiscountExpirationDate TEXT,
        $columnDocumentImages TEXT,
        $columnContracts TEXT,
        $columnActivityLog TEXT,
        $columnResponsibleEmployee TEXT
      )
    ''');
  }

  Future<void> insertCustomer(Map<String, dynamic> customer) async {
    Database db = await database;
    await db.insert(tableName, customer);
  }

  Future<void> updateCustomer(Map<String, dynamic> customer) async {
    Database db = await database;
    await db.update(tableName, customer,
        where: '$columnId = ?', whereArgs: [customer[columnId]]);
  }

  Future<void> deleteCustomer(int id) async {
    Database db = await database;
    await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getCustomers() async {
    Database db = await database;
    return await db.query(tableName);
  }

  Future<void> close() async {
    Database db = await database;
    db.close();
  }
}
