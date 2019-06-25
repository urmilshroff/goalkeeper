import 'dart:async';
import 'dart:io';

import 'package:goalkeeper/utils/goal.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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
        $colBody TEXT NOT NULL)''');
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "goals.db");
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDatabase();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> getGoalsMapList() async {
    Database db = await this.database;
    var result = await db.query(goalsTable);
    return result;
  }

  Future<int> createGoal(GoalClass goal) async {
    Database db = await this.database;
    var result = await db.insert(goalsTable, goal.toMap());
    return result;
  }

  Future<int> updateGoal(GoalClass goal) async {
    Database db = await this.database;
    var result = await db.update(goalsTable, goal.toMap(),
        where: "$colId=?", whereArgs: [goal.id]);
    return result;
  }

  Future<int> deleteGoal(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $goalsTable WHERE $colId = $id');
    return result;
  }

  Future<int> getCount(GoalClass goal) async {
    Database db = await this.database;
    List<Map<String, dynamic>> num = await db.query(goalsTable);
    var result = Sqflite.firstIntValue(num);
    return result;
  }

  Future<List<GoalClass>> getGoalsList() async {
    var goalsMapList = await getGoalsMapList();
    List<GoalClass> goalsList = List<GoalClass>();

    for (int i = 0; i < goalsMapList.length; i++) {
      goalsList.add(GoalClass.fromMap(goalsMapList[i])); //converts from map
      // to list
    }
    return goalsList;
  }
}
