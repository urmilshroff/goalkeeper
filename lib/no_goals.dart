import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:goalkeeper/colors.dart';
import 'package:goalkeeper/my_goal.dart';
import 'package:goalkeeper/database_helper.dart';
import 'package:goalkeeper/public.dart';
import 'package:goalkeeper/about_page.dart';
import 'package:goalkeeper/no_goals.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:goalkeeper/goals_page.dart';

Widget buildNoGoals(BuildContext context) {
  return Container(
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            EvaIcons.flag,
            size: 64.0,
            color: invertColors(context),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("No goals yet",
                style: TextStyle(fontSize: 18.0, color: invertColors(context))),
          ),
        ],
      ),
    ),
  );
}
