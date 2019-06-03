import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:goalkeeper/main.dart';
import 'package:goalkeeper/colors.dart';
import 'package:goalkeeper/new_goal.dart';
import 'package:goalkeeper/edit_goal.dart';

import 'package:dynamic_theme/dynamic_theme.dart';

class GoalsPage extends StatefulWidget {
  @override
  GoalsPageState createState() => GoalsPageState();
}

class GoalsPageState extends State<GoalsPage> {
  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        isThemeCurrentlyDark(context) ? Brightness.light : Brightness.dark);
  } //switch between light & dark modes

  Widget _buildGoalsList() {
    return Container(
      child: ListView.builder(itemBuilder: (context, index) {
        if (index < goalTitlesList.length) {
          return buildNewGoal(index, context);
        }
      }),
    );
  } //builds goals list

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    inputGoalTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: MyColors.primaryColor,
        title: Text('My Goals',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0)),
        actions: <Widget>[
          IconButton(
            icon: isThemeCurrentlyDark(context)
                ? Icon(Icons.brightness_7) //use sun icon
                : Icon(Icons.brightness_2), //use moon icon
            tooltip: isThemeCurrentlyDark(context)
                ? "Switch to light mode"
                : "Switch to dark mode",
            onPressed: changeBrightness,
          ),
        ],
      ),
      body: noGoals == true
          ? Center(
              child: Text("No goals yet :(",
                  style:
                      TextStyle(color: invertColors(context), fontSize: 24.0)))
          : _buildGoalsList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          createNewGoal(context);
        },
        icon: Icon(Icons.add),
        label: Text("NEW GOAL"),
        foregroundColor: MyColors.light,
        backgroundColor: MyColors.accentColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 5.0,
      ),
    );
  }
}
