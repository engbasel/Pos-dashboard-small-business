import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb {
  static Database? _db;

  Future<Database?> get db async {
    _db ??= await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async {
    // var databasesPath = await getDatabasesPath();

    // String path = join(databasesPath, DBmanger.databaseName);

    Directory appDocDir = Directory(Platform.environment['APPDATA']!);
    String appDocPath = appDocDir.path;
    String path = join(appDocPath, 'POSdatabases', DBmanger.databaseName);

    if (!await Directory(join(appDocPath, 'POSdatabases')).exists()) {
      await Directory(join(appDocPath, 'POSdatabases')).create(recursive: true);
    }

    return await openDatabase(
      path,
      version: 2,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE user (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       username TEXT NOT NULL,
       birthday TEXT,
       privilege TEXT,
       gender TEXT,
       email TEXT,
       branch TEXT,
       createdAt TEXT,
       createdTime TEXT
     )''',
    );
    debugPrint('=========== Database Created ===========');
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint('=========== Version of Database changed ===========');
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    Database? mydb = await db;
    return await mydb!.insert('user', user);
  }

  Future<List<Map<String, dynamic>>> getUserData() async {
    Database? mydb = await db;
    return await mydb!.query('user');
  }

  Future<int> deleteUserData(String id) async {
    Database? mydb = await db;
    return await mydb!.delete('user', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> debugPrintAllUserData() async {
    List<Map<String, dynamic>> users = await getUserData();
    for (var user in users) {
      debugPrint('================= $user ==========================');
    }
  }
}
