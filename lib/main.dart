import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:goalkeeper/Pages/Home.dart';
import 'package:goalkeeper/Utils/colors.dart';

  runApp(MyApp(
    repository: Factory().repository,
  ));

class MyApp extends StatelessWidget {
  final IRepository repository;
  MyApp({@required this.repository});

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
          home: Home(repository: this.repository),
        );
      },
    );
  }
}
