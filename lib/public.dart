import 'package:flutter/material.dart';

import 'package:goalkeeper/main.dart';
import 'package:goalkeeper/goals_page.dart';
import 'package:goalkeeper/database_helper.dart';
import 'package:goalkeeper/colors.dart';

//publicly usable methods and variables

List<String> goalTitlesList = [];
List<String> goalBodiesList = [];
String inputGoalTitle;
TextEditingController inputGoalTitleController = new TextEditingController();
TextEditingController inputGoalBodyController = new TextEditingController();
bool noGoals = true;
int goalIndex = 0;

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
  goalIndex++;
  DatabaseHelper helper = DatabaseHelper.instance;
  MyGoal goal = await helper.queryMyGoal(goalIndex);
  print("Goal Index: ${goalIndex}, Goal Title: ${goal.title}, Goal Body: ${goal.body}");
}

saveDataToDB(String inputGoalTitle, String inputGoalBody) async {
  MyGoal goal = MyGoal();
  goal.title = "$inputGoalTitle";
  goal.body = "$inputGoalBody";
  DatabaseHelper helper = DatabaseHelper.instance;
  int goalIndex = await helper.insert(goal);
  print("Goal Index: ${goalIndex}, Goal Title: ${goal.title}, Goal Body: ${goal.body}");
}
