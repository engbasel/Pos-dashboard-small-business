// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import '../models/CategoryModel.dart';

// class CategoryDatabaseHelper {
//   static final CategoryDatabaseHelper instance =
//       CategoryDatabaseHelper._privateConstructor();
//   static Database? _database;

//   CategoryDatabaseHelper._privateConstructor();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'categories.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: onCreate,
//     );
//   }

//   Future<void> onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE categories (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         title TEXT,
//         color INTEGER
//       )
//     ''');
//     print("Created categories table");
//   }

//   Future<void> insertCategory(CategoryModel category) async {
//     final db = await database;
//     await db.insert(
//       'categories',
//       category.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     print("Inserted category: ${category.title}");
//   }

//   Future<List<CategoryModel>> getCategories() async {
//     final db = await database;
//     var categories = await db.query('categories', orderBy: 'id');
//     List<CategoryModel> categoryList = categories.isNotEmpty
//         ? categories.map((c) => CategoryModel.fromMap(c)).toList()
//         : [];
//     print("Fetched categories: ${categoryList.length}");
//     return categoryList;
//   }

//   Future<void> deleteCategory(int id) async {
//     final db = await database;
//     await db.delete('categories', where: 'id = ?', whereArgs: [id]);
//     print("Deleted category with id: $id");
//   }
// }
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/CategoryModel.dart';
import 'category_database_constants.dart';

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
    String path = join(
        await getDatabasesPath(), CategoryDatabaseConstants.databaseFileName);
    return await openDatabase(
      path,
      version: CategoryDatabaseConstants.versionDatabase,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${CategoryDatabaseConstants.categoriesTable} (
        ${CategoryDatabaseConstants.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${CategoryDatabaseConstants.columnTitle} TEXT,
        ${CategoryDatabaseConstants.columnColor} INTEGER
      )
    ''');
    print(
        "Created categories table with columns: ${CategoryDatabaseConstants.columnId}, ${CategoryDatabaseConstants.columnTitle}, ${CategoryDatabaseConstants.columnColor}");
  }

  Future<void> insertCategory(CategoryModel category) async {
    final db = await database;
    await db.insert(
      CategoryDatabaseConstants.categoriesTable,
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Inserted category: ${category.title}");
  }

  Future<List<CategoryModel>> getCategories() async {
    final db = await database;
    var categories = await db.query(CategoryDatabaseConstants.categoriesTable,
        orderBy: CategoryDatabaseConstants.columnId);
    List<CategoryModel> categoryList = categories.isNotEmpty
        ? categories.map((c) => CategoryModel.fromMap(c)).toList()
        : [];
    print("Fetched categories: ${categoryList.length}");
    return categoryList;
  }

  Future<void> deleteCategory(int id) async {
    final db = await database;
    await db.delete(CategoryDatabaseConstants.categoriesTable,
        where: '${CategoryDatabaseConstants.columnId} = ?', whereArgs: [id]);
    print("Deleted category with id: $id");
  }
}
