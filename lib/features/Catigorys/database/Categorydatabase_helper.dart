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
  }

  Future<void> insertCategory(Category category) async {
    final db = await database;
    await db.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(
        '''============= Inserted category in table 'categories' ======== with data: ${category.toMap()} ============== ''');
  }

  Future<List<Category>> getCategories() async {
    Database db = await instance.database;
    var categories = await db.query('categories', orderBy: 'id');
    List<Category> categoryList = categories.isNotEmpty
        ? categories.map((c) => Category.fromMap(c)).toList()
        : [];
    return categoryList;
  }

  Future<int> deleteCategory(int id) async {
    Database db = await instance.database;
    return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }
}
