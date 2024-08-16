import 'package:pos_dashboard_v1/features/client/database/constantsCustomersHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

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

    print('Database path: $path');

    if (!await Directory(join(appDocPath, dbPathFolderName)).exists()) {
      await Directory(join(appDocPath, dbPathFolderName))
          .create(recursive: true);
      print('Created database directory at $appDocPath/$dbPathFolderName');
    }

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        createDatabase(db, version);
        print('Database created with version: $version');
      },
      onOpen: (db) {
        print('Database opened: ${db.path}');
      },
    );
  }

  Future<Map<String, dynamic>?> getCustomerById(int id) async {
    Database db = await database;
    try {
      final List<Map<String, dynamic>> result = await db.query(
        tableName,
        where: '$columnId = ?',
        whereArgs: [id],
      );
      if (result.isNotEmpty) {
        return result.first;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching customer by ID: $e');
      return null;
    }
  }

  Future<void> insertCustomer(Map<String, dynamic> customerData) async {
    final db = await database; // Replace with your database reference

    try {
      await db.insert(
        'customers',
        customerData,
        conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts
      );
      print('Customer data inserted into the database');
    } catch (e) {
      print('Error inserting customer: $e');
    }
  }

  void createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT,
        $columnPhoneNumber TEXT,
        $columnEmail TEXT,
        $columnAddress TEXT,
        $columnNotes TEXT,
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
        $columnCustomerInterests TEXT,
        $columnCustomerSatisfactionLevel TEXT,
        $columnAnnualPurchaseVolume REAL,
        $columnComplaintCount INTEGER,
        $columnComplaintResolutionHistory TEXT,
        $columnSupportRating TEXT,
        $columnCustomerDiscount REAL,
        $columnActiveOffers TEXT,
        $columnResponsibleEmployee TEXT
      )
    ''');
    print(
        'Table $tableName created with columns: $columnName, $columnPhoneNumber, $columnEmail, ...');
  }

  Future<void> resetDatabase() async {
    Database db = await database;
    await db.execute('DROP TABLE IF EXISTS $tableName');
    createDatabase(db, 1);
    print('Database reset and table $tableName recreated');
  }

  Future<void> updateCustomer(Map<String, dynamic> customer) async {
    Database db = await database;
    try {
      await db.update(
        tableName,
        customer,
        where: '$columnId = ?',
        whereArgs: [customer[columnId]],
      );
      print('Updated customer: $customer');
    } catch (e) {
      print('Error updating customer: $e');
    }
  }

  Future<void> deleteCustomer(int id) async {
    Database db = await database;
    try {
      await db.delete(
        tableName,
        where: '$columnId = ?',
        whereArgs: [id],
      );
      print('Deleted customer with id: $id');
    } catch (e) {
      print('Error deleting customer: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getCustomers() async {
    Database db = await database;
    try {
      List<Map<String, dynamic>> customers = await db.query(tableName);
      print('Fetched customers: $customers');
      return customers;
    } catch (e) {
      print('Error fetching customers: $e');
      return [];
    }
  }

  Future<void> close() async {
    Database db = await database;
    await db.close();
    print('Database closed');
  }
}
