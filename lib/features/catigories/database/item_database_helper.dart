import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/CategoryModel.dart';

class ItemDatabaseHelper {
  static final ItemDatabaseHelper instance =
      ItemDatabaseHelper.privateConstructor();
  static Database? _database;

  ItemDatabaseHelper.privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'items.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryId INTEGER,
        name TEXT,
        description TEXT,
        FOREIGN KEY (categoryId) REFERENCES categories (id)
      )
    ''');
    print("Created items table");
  }

  Future<void> insertItem(Item item) async {
    final db = await database;
    await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Inserted item: ${item.name}");
  }

  Future<List<Item>> getItems(int categoryId) async {
    final db = await database;
    var items = await db.query('items',
        where: 'categoryId = ?', whereArgs: [categoryId], orderBy: 'id');
    List<Item> itemList =
        items.isNotEmpty ? items.map((i) => Item.fromMap(i)).toList() : [];
    print("Fetched items for category $categoryId: ${itemList.length}");
    return itemList;
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete('items', where: 'id = ?', whereArgs: [id]);
    print("Deleted item with id: $id");
  }

  Future<void> updateItem(Item item) async {
    final db = await database;
    await db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
    print("Updated item with id: ${item.id}");
  }
}
