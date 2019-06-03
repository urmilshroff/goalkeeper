import 'package:flutter/material.dart';

import 'package:goalkeeper/colors.dart';
import 'package:goalkeeper/goals_page.dart';

import 'package:dynamic_theme/dynamic_theme.dart';

List<String> goalTitlesList = [];
List<String> goalBodiesList = [];
String inputGoalTitle;
TextEditingController inputGoalTitleController = new TextEditingController();
bool noGoals = true;

bool isThemeCurrentlyDark(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return true; //if currently in dark mode
  } else {
    return false;
  }
} //returns current theme state

Color invertColors(BuildContext context) {
  if (isThemeCurrentlyDark(context)) {
    return MyColors.light;
  } else {
    return MyColors.dark;
  }
} //returns appropriate colors for text visibility

Widget buildTile(Widget widgetContent, {Function() onTap}) {
  return Container(
    margin: const EdgeInsets.all(5.0),
    child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
              primaryColor: MyColors.primaryColor,
              accentColor: MyColors.accentColor,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            title: "Goalkeeper",
            theme: theme,
            home: GoalsPage(),
          );
        });
  }
}
