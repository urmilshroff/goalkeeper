import 'dart:io';
import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class MyGoal {
  int _id;
  String _title;
  String _body;

  int get index => _id;
  String get title => _title;
  String get body => _body;

  set title(String newTitle) {
    this._title = newTitle;
  }

  set body(String newBody) {
    this._title = newBody;
  }

  MyGoal(this._id, this._title, this._body);

  MyGoal.fromMap(Map<String, dynamic> map) {
    _id = map["id"];
    _title = map["title"];
    _body = map["title"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map["id"] = _id;
    }
    map["title"] = _title;
    map["body"] = _body;

    return map;
  }
}

//class DatabaseHelper {
//  DatabaseHelper._privateConstructor();
//  static final _databaseName = "GoalsDatabase.db";
//  static final _databaseVersion = 1;
//  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//  static Database _database;
//
//  Future<Database> get database async {
//    if (_database != null) return _database;
//    _database = await _initDatabase();
//    return _database;
//  }
//
//  _initDatabase() async {
//    Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    String path = join(documentsDirectory.path, _databaseName);
//    return await openDatabase(path,
//        version: _databaseVersion, onCreate: _onCreate);
//  }
//
//  Future _onCreate(Database db, int version) async {
//    await db.execute('''
//              CREATE TABLE $goalsTable (
//                $goalIndex INTEGER PRIMARY KEY,
//                $goalTitle TEXT NOT NULL,
//                $goalBody TEXT NOT NULL
//              )
//              ''');
//  }
//
//  Future<int> insert(MyGoal _title) async {
//    Database db = await database;
//    int _index = await db.insert(goalsTable, _title.toMap());
//    return _index;
//  }
//
//  Future<MyGoal> queryMyGoal(int _index) async {
//    Database db = await database;
//    List<Map> maps = await db.query(goalsTable,
//        columns: [goalIndex, goalTitle, goalBody],
//        where: '$goalIndex = ?',
//        whereArgs: [_index]);
//    if (maps.length > 0) {
//      return MyGoal.fromMap(maps.first);
//    }
//    return null;
//  }
//}

class DatabaseHelper {
  static Database _database; //singleton database object
  static DatabaseHelper _databaseHelper; //singleton database helper object

  String goalsTable = "goal_table";
  String colId = "id";
  String colTitle = "title";
  String colBody = "body";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''CREATE TABLE $goalsTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTitle TEXT NOT NULL,
        $colTitle TEXT NOT NULL)''');
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "goals.db");
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> getGoalsMapList() async {
    Database db = await this.database;
    var result = await db.query(goalsTable);
    return result;
  }

  Future<int> createGoal(MyGoal goal) async {
    Database db = await this.database;
    var result = await db.insert(goalsTable, goal.toMap());
    return result;
  }

  Future<int> updateGoal(MyGoal goal) async {
    Database db = await this.database;
    var result = await db.update(goalsTable, goal.toMap(),
        where: "$colId=?", whereArgs: [goal._id]);
    return result;
  }

  Future<int> deleteGoal(MyGoal goal) async {
    Database db = await this.database;
    var result =
        await db.delete(goalsTable, where: "$colId=?", whereArgs: [goal._id]);
    return result;
  }

  Future<int> getCount(MyGoal goal) async {
    Database db = await this.database;
    List<Map<String, dynamic>> num = await db.query(goalsTable);
    var result = Sqflite.firstIntValue(num);
    return result;
  }
}
