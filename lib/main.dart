import 'package:flutter/material.dart';

import 'package:goalkeeper/colors.dart';
import 'package:goalkeeper/goals_page.dart';

import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
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
