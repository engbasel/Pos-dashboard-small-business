// import 'package:pos_dashboard_v1/features/categories/models/category_model.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class CategoryDatabaseHelper {
//   static final CategoryDatabaseHelper _instance =
//       CategoryDatabaseHelper._internal();

//   factory CategoryDatabaseHelper() {
//     return _instance;
//   }

//   CategoryDatabaseHelper._internal();

//   static Database? _database;

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
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE categories(id INTEGER PRIMARY KEY, title TEXT, color INTEGER)',
//         );
//       },
//     );
//   }

//   Future<List<CategoryModel>> getCategories() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('categories');

//     return List.generate(maps.length, (i) {
//       return CategoryModel(
//         id: maps[i]['id'],
//         title: maps[i]['title'],
//         color: maps[i]['color'],
//       );
//     });
//   }

//   Future<void> insertCategory(CategoryModel category) async {
//     final db = await database;
//     await db.insert(
//       'categories',
//       category.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
// }
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/category_model.dart';

class CategoryDatabaseHelper {
  CategoryDatabaseHelper._privateConstructor();
  static final CategoryDatabaseHelper instance =
      CategoryDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'category_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        color INTEGER
      )
      ''');
  }

  Future<List<CategoryModel>> getCategories() async {
    Database db = await instance.database;
    var categories = await db.query('categories', orderBy: 'title');
    List<CategoryModel> categoryList = categories.isNotEmpty
        ? categories.map((c) => CategoryModel.fromMap(c)).toList()
        : [];
    return categoryList;
  }

  Future<int> insertCategory(CategoryModel category) async {
    Database db = await instance.database;
    return await db.insert('categories', category.toMap());
  }

  Future<int> deleteCategory(int id) async {
    Database db = await instance.database;
    return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }
}
