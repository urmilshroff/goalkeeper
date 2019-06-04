import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// database table and goal names
final String goalsTable = 'goalsTable';
final String goalId = '_id';
final String goalTitle = 'title';
final String goalBody = 'body';

class MyTitle {
  int id;
  String title;
  String body;

  MyTitle();
  MyTitle.fromMap(Map<String, dynamic> map) {
    id = map[goalId];
    title = map[goalTitle];
    body = map[goalBody];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{goalTitle: title, goalBody: body};
    if (id != null) {
      map[goalId] = id;
    }
    return map;
  }
}

class DatabaseHelper {
  // database filename that is saved in the docs directory
  static final _databaseName = "GoalsDatabase.db";
  // increment this version when you need to change the schema
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only allow a single open connection to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // the path_provider plugin gets the right directory for Android or iOS
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // open the database
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $goalsTable (
                $goalId INTEGER PRIMARY KEY,
                $goalTitle TEXT NOT NULL,
                $goalBody TEXT NOT NULL
              )
              ''');
  }

  Future<int> insert(MyTitle title) async {
    Database db = await database;
    int id = await db.insert(goalsTable, title.toMap());
    return id;
  }

  Future<MyTitle> queryMyTitle(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(goalsTable,
        columns: [goalId, goalTitle, goalBody],
        where: '$goalId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return MyTitle.fromMap(maps.first);
    }
    return null;
  }
}
