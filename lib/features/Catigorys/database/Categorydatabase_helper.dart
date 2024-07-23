import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/CategoryModel.dart';

class CategoryDatabaseHelper {
  static final CategoryDatabaseHelper instance =
      CategoryDatabaseHelper._privateConstructor();
  static Database? _database;

  CategoryDatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'categories.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        color INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryId INTEGER,
        name TEXT,
        description TEXT,
        FOREIGN KEY (categoryId) REFERENCES categories (id)
      )
    ''');
  }

  Future<void> insertCategory(Category category) async {
    final db = await database;
    await db.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Category>> getCategories() async {
    final db = await database;
    var categories = await db.query('categories', orderBy: 'id');
    List<Category> categoryList = categories.isNotEmpty
        ? categories.map((c) => Category.fromMap(c)).toList()
        : [];
    return categoryList;
  }

  Future<void> insertItem(Item item) async {
    final db = await database;
    await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Item>> getItems(int categoryId) async {
    final db = await database;
    var items = await db.query('items',
        where: 'categoryId = ?', whereArgs: [categoryId], orderBy: 'id');
    List<Item> itemList =
        items.isNotEmpty ? items.map((i) => Item.fromMap(i)).toList() : [];
    return itemList;
  }

  Future<void> deleteCategory(int id) async {
    final db = await database;
    await db.delete('categories', where: 'id = ?', whereArgs: [id]);
    await db.delete('items', where: 'categoryId = ?', whereArgs: [id]);
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateItem(Item item) async {
    final db = await database;
    await db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> _addCategory(String title, int color) async {
    final category = Category(title: title, color: color);
    await CategoryDatabaseHelper.instance.insertCategory(category);
  }

  Future<void> _addItem(int categoryId, String name, String description) async {
    final item =
        Item(categoryId: categoryId, name: name, description: description);
    await CategoryDatabaseHelper.instance.insertItem(item);
  }

  Future<void> _deleteCategory(int id) async {
    await CategoryDatabaseHelper.instance.deleteCategory(id);
  }

  Future<void> _deleteItem(int id) async {
    await CategoryDatabaseHelper.instance.deleteItem(id);
  }
}
