import 'package:flutter/material.dart';

import 'package:goalkeeper/colors.dart';
import 'package:goalkeeper/main.dart';
import 'package:goalkeeper/goals_page.dart';

import 'package:dynamic_theme/dynamic_theme.dart';

//publicly usable methods and variables

List<String> goalTitlesList = [];
List<String> goalBodiesList = [];
String inputGoalTitle;
TextEditingController inputGoalTitleController = new TextEditingController();
TextEditingController inputGoalBodyController = new TextEditingController();
bool noGoals = true;

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
