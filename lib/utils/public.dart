import 'package:flutter/material.dart';

import 'package:goalkeeper/utils/colors.dart';

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
} //returns current theme status

Color invertColors(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return MyColors.light;
  } else {
    return MyColors.dark;
  }
} //returns appropriate colors for text visibility

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  Scaffold.of(context).showSnackBar(snackBar);
} //easily display a snackbar

Widget buildTile(Widget widgetContent, {Function() onTap}) {
  return Container(
    margin: const EdgeInsets.all(5.0),
    child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: onTap != null
              ? () => onTap()
              : () {
                  print("Nothing set");
                },
          child: widgetContent,
          splashColor: MyColors.accentColor,
        )),
  );
} //build material goal card
