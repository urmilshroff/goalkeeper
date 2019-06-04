import 'package:flutter/material.dart';

import 'package:goalkeeper/main.dart';
import 'package:goalkeeper/goals_page.dart';
import 'package:goalkeeper/database_helper.dart';
import 'package:goalkeeper/colors.dart';

import 'package:dynamic_theme/dynamic_theme.dart';

//publicly usable methods and variables

List<String> goalTitlesList = [];
List<String> goalBodiesList = [];
String inputGoalTitle;
TextEditingController inputGoalTitleController = new TextEditingController();
TextEditingController inputGoalBodyController = new TextEditingController();
bool noGoals = true;
int rowId = 1;

bool isThemeCurrentlyDark(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return true; //if currently in dark mode
  } else {
    return false;
  }
} //returns current theme

Color invertColors(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return MyColors.light;
  } else {
    return MyColors.dark;
  }
} //returns appropriate colors for text visibility

readDataFromDB() async {
  DatabaseHelper helper = DatabaseHelper.instance;
  MyGoal goal = await helper.queryMyGoal(rowId);
  if (goal == null) {
    print('read row $rowId: empty');
  } else {
    print('read row $rowId: ${goal.title} ${goal.body}');
  }
  rowId++;
}

saveDataToDB() async {
  MyGoal goal = MyGoal();
  goal.title = "hello";
  goal.body = "world";
  DatabaseHelper helper = DatabaseHelper.instance;
  int id = await helper.insert(goal);
  print('inserted row: $id');
}
