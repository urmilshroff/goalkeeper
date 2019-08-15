import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:goalkeeper/Pages/Home.dart';
import 'package:goalkeeper/Services/Db.dart';
import 'package:goalkeeper/Services/Factory.dart';
import 'package:goalkeeper/Services/GoalsRepository.dart';
import 'package:goalkeeper/Services/Interfaces/IRepository.dart';
import 'package:goalkeeper/Services/NotificationCenter.dart';
import 'package:goalkeeper/Utils/colors.dart';

void main() {
  prepareDependencies();
  runApp(MyApp(
    repository: Factory().repository,
  ));
}

// Composition root for our dependencies !
void prepareDependencies() {
  var factory = Factory();
  factory.registerDatabase(Db());
  factory.registerRepository(GoalsRepository(database: factory.database));
  factory.registerNotificationCenter(
      NotificationCenter(repository: factory.repository));
}

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
