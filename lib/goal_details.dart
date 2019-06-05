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

class GoalDetail extends StatefulWidget {
  final String appBarTitle;
  final MyGoal goal;

  GoalDetail(this.goal, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return GoalDetailState(this.goal, this.appBarTitle);
  }
}

class GoalDetailState extends State<GoalDetail> {
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  MyGoal goal;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  GoalDetailState(this.goal, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = goal.title;
    bodyController.text = goal.body;

    return WillPopScope(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Title Text Field');
                  updateTitle();
                },
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            // Third Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: bodyController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Body Text Field');
                  updateBody();
                },
                decoration: InputDecoration(
                    labelText: 'Body',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            // Fourth Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint("Save button clicked");
                          _save();
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint("Delete button clicked");
                          _delete();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  // Update the title of Goal object
  void updateTitle() {
    goal.title = titleController.text;
  }

  // Update the body of Goal object
  void updateBody() {
    goal.body = bodyController.text;
  }

  // Save data to database
  void _save() async {
    Navigator.pop(context);

    int result;
    if (goal.id != null) {
      // Case 1: Update operation
      result = await helper.updateGoal(goal);
    } else {
      // Case 2: Insert Operation
      result = await helper.createGoal(goal);
    }

    if (result != 0) {
      // Success
//      _showAlertDialog('Status', 'Goal Saved Successfully');
    } else {
      // Failure
//      _showAlertDialog('Status', 'Problem Saving Goal');
    }
  }

  void _delete() async {
    Navigator.pop(context);

    if (goal.id == null) {
//      _showAlertDialog('Status', 'No Goal was deleted');
      return;
    }

    int result = await helper.deleteGoal(goal.id);
    if (result != 0) {
//      _showAlertDialog('Status', 'Goal Deleted Successfully');
    } else {
//      _showAlertDialog('Status', 'Error Occured while Deleting Goal');
    }
  }
}
