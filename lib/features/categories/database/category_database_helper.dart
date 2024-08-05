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

  Future<int> getCategoryCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM categories')) ??
        0;
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

  Future<int> updateCategory(CategoryModel category) async {
    Database db = await instance.database;
    return await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> deleteCategory(int id) async {
    Database db = await instance.database;
    return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }
}
