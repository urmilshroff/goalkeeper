import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// database table and goal names
final String goalsTable = 'goalsTable';
final String goalIndex = '_id';
final String goalTitle = 'title';
final String goalBody = 'body';

class MyGoal {
  int index;
  String title;
  String body;

  MyGoal();
  MyGoal.fromMap(Map<String, dynamic> map) {
    index = map[goalIndex];
    title = map[goalTitle];
    body = map[goalBody];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{goalTitle: title, goalBody: body};
    if (index != null) {
      map[goalIndex] = index;
    }
    return map;
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final _databaseName = "GoalsDatabase.db";
  static final _databaseVersion = 1;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $goalsTable (
                $goalIndex INTEGER PRIMARY KEY,
                $goalTitle TEXT NOT NULL,
                $goalBody TEXT NOT NULL
              )
              ''');
  }

  Future<int> insert(MyGoal title) async {
    Database db = await database;
    int index = await db.insert(goalsTable, title.toMap());
    return index;
  }

  Future<MyGoal> queryMyGoal(int index) async {
    Database db = await database;
    List<Map> maps = await db.query(goalsTable,
        columns: [goalIndex, goalTitle, goalBody],
        where: '$goalIndex = ?',
        whereArgs: [index]);
    if (maps.length > 0) {
      return MyGoal.fromMap(maps.first);
    }
    return null;
  }
}
