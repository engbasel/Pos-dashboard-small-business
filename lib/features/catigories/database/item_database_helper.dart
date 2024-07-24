// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:pos_dashboard_v1/features/catigories/models/ItemModel.dart';
// import 'package:sqflite/sqflite.dart';

// class ItemDatabaseHelper {
//   static final ItemDatabaseHelper instance =
//       ItemDatabaseHelper.privateConstructor();
//   static Database? _database;

//   ItemDatabaseHelper.privateConstructor();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await initDatabase();
//     return _database!;
//   }

//   Future<Database> initDatabase() async {
//     String path = join(await getDatabasesPath(), 'items.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: onCreate,
//     );
//   }

//   Future<void> onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE items (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         categoryId INTEGER,
//         name TEXT,
//         description TEXT,
//         FOREIGN KEY (categoryId) REFERENCES categories (id)
//       )
//     ''');
//     print("Created items table");
//   }

//   Future<void> insertItem(ItemModel item) async {
//     final db = await database;
//     await db.insert(
//       'items',
//       item.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     print("Inserted item: ${item.name}");
//   }

//   Future<List<ItemModel>> getItems(int categoryId) async {
//     final db = await database;
//     var items = await db.query('items',
//         where: 'categoryId = ?', whereArgs: [categoryId], orderBy: 'id');
//     List<ItemModel> itemList =
//         items.isNotEmpty ? items.map((i) => ItemModel.fromMap(i)).toList() : [];
//     print("Fetched items for category $categoryId: ${itemList.length}");
//     return itemList;
//   }

//   Future<void> deleteItem(int id) async {
//     final db = await database;
//     await db.delete('items', where: 'id = ?', whereArgs: [id]);
//     print("Deleted item with id: $id");
//   }

//   Future<void> updateItem(ItemModel item) async {
//     final db = await database;
//     await db.update(
//       'items',
//       item.toMap(),
//       where: 'id = ?',
//       whereArgs: [item.id],
//     );
//     print("Updated item with id: ${item.id}");
//   }
// }

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/ItemModel.dart';
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
        ${ItemDatabaseConstants.columnName} TEXT,
        ${ItemDatabaseConstants.columnDescription} TEXT,
        FOREIGN KEY (${ItemDatabaseConstants.columnCategoryId}) REFERENCES categories (${ItemDatabaseConstants.columnId})
      )
    ''');
    print(
        "Created items table with columns: ${ItemDatabaseConstants.columnId}, ${ItemDatabaseConstants.columnCategoryId}, ${ItemDatabaseConstants.columnName}, ${ItemDatabaseConstants.columnDescription}");
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
}
