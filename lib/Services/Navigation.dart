import 'package:flutter/cupertino.dart';
import 'package:goalkeeper/Models/Goal.dart';
import 'package:goalkeeper/Pages/CreateGoal.dart';
import 'package:goalkeeper/Pages/EditGoal.dart';
import 'package:goalkeeper/Services/Factory.dart';

void goToCreateGoal(context) async {
  await Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) {
        return CreateGoal(
          repository: Factory().repository,
          notificationCenter: Factory().notificationCenter,
        );
      },
    ),
  );
}

void goToEditGoal(context, Goal goal) async {
  await Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) {
        return EditGoal(goal,
            notificationCenter: Factory().notificationCenter,
            repository: Factory().repository);
      },
    ),
  );
}
