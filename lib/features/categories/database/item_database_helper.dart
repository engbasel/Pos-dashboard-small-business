import 'dart:async';
import 'package:path/path.dart';
import 'package:pos_dashboard_v1/features/categories/database/category_database_constants.dart';
import 'package:sqflite/sqflite.dart';
import '../models/item_model.dart';
import 'item_database_constants.dart';

class ItemDatabaseHelper {
  static final ItemDatabaseHelper instance =
      ItemDatabaseHelper._privateConstructor();
  static Database? _database;

  ItemDatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path =
        join(await getDatabasesPath(), ItemDatabaseConstants.databaseFileName);
    return await openDatabase(
      path,
      version: ItemDatabaseConstants.versionDatabase,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
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
    print(
        "Created items table with columns: ${ItemDatabaseConstants.columnId}, ${ItemDatabaseConstants.columnCategoryId}, ${ItemDatabaseConstants.columnName}, ${ItemDatabaseConstants.columnDescription}, ${ItemDatabaseConstants.columnSKU}, ${ItemDatabaseConstants.columnBarcode}, ${ItemDatabaseConstants.columnPurchasePrice}, ${ItemDatabaseConstants.columnSalePrice}, ${ItemDatabaseConstants.columnWholesalePrice}, ${ItemDatabaseConstants.columnTaxRate}, ${ItemDatabaseConstants.columnQuantity}, ${ItemDatabaseConstants.columnAlertQuantity}, ${ItemDatabaseConstants.columnImage}, ${ItemDatabaseConstants.columnBrand}, ${ItemDatabaseConstants.columnSize}, ${ItemDatabaseConstants.columnWeight}, ${ItemDatabaseConstants.columnColor}, ${ItemDatabaseConstants.columnMaterial}, ${ItemDatabaseConstants.columnWarranty}, ${ItemDatabaseConstants.columnSupplierId}, ${ItemDatabaseConstants.columnItemStatus}, ${ItemDatabaseConstants.columnDateAdded}, ${ItemDatabaseConstants.columnDateModified}");
  }

  Future<void> insertItem(ItemModel item) async {
    final db = await database;
    await db.insert(
      ItemDatabaseConstants.itemsTable,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Inserted item: ${item.name}");
  }

  Future<void> insertItemInTransaction(
      DatabaseExecutor txn, ItemModel item) async {
    await txn.insert(
      ItemDatabaseConstants.itemsTable,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Inserted item: ${item.name}");
  }

  Future<ItemModel?> getItem(int id) async {
    final db = await database;
    var result = await db.query(
      ItemDatabaseConstants.itemsTable,
      where: '${ItemDatabaseConstants.columnId} = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return ItemModel.fromMap(result.first);
    }
    return null;
  }

  Future<void> updateItem(ItemModel item) async {
    final db = await database;
    await db.update(
      ItemDatabaseConstants.itemsTable,
      item.toMap(),
      where: '${ItemDatabaseConstants.columnId} = ?',
      whereArgs: [item.id],
    );
    print("Updated item with id: ${item.id}");
  }

  Future<List<ItemModel>> getAllItems() async {
    final db = await database;
    var items = await db.query(
      ItemDatabaseConstants.itemsTable,
      orderBy: ItemDatabaseConstants.columnId,
    );
    List<ItemModel> itemList =
        items.isNotEmpty ? items.map((i) => ItemModel.fromMap(i)).toList() : [];
    print("Fetched all items: ${itemList.length}");
    return itemList;
  }

  Future<List<ItemModel>> getItems(int categoryId) async {
    final db = await database;
    var items = await db.query(
      ItemDatabaseConstants.itemsTable,
      where: '${ItemDatabaseConstants.columnCategoryId} = ?',
      whereArgs: [categoryId],
      orderBy: ItemDatabaseConstants.columnId,
    );
    List<ItemModel> itemList =
        items.isNotEmpty ? items.map((i) => ItemModel.fromMap(i)).toList() : [];
    print("Fetched items for category $categoryId: ${itemList.length}");
    return itemList;
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete(ItemDatabaseConstants.itemsTable,
        where: '${ItemDatabaseConstants.columnId} = ?', whereArgs: [id]);
    print("Deleted item with id: $id");
  }
}
