import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:goalkeeper/utils/database_helper.dart';
import 'package:goalkeeper/utils/goal.dart';
import 'package:goalkeeper/utils/public.dart';

class EditGoal extends StatefulWidget {
  final String appBarTitle;
  final GoalClass goal;

  EditGoal(this.goal, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return EditGoalState(this.goal, this.appBarTitle);
  }
}

class EditGoalState extends State<EditGoal> {
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  GoalClass goal;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  EditGoalState(this.goal, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = goal.title;
    bodyController.text = goal.body;

    return WillPopScope(
        //TODO fuck this off
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
                          saveGoal();
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
                          deleteGoal();
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

  void updateTitle() {
    goal.title = titleController.text;
  }

  void updateBody() {
    goal.body = bodyController.text;
  }

  void saveGoal() async {
    int result;

    Navigator.pop(context);

    if (goal.id != null) {
      result = await helper.updateGoal(goal);
    } else {
      result = await helper.createGoal(goal);
    }

    if (result != 0) {
      showSnackBar(context, "Goal saved!");
    } else {
      showSnackBar(context, "Error saving goal");
    }
  }

  void deleteGoal() async {
    Navigator.pop(context);

    if (goal.id == null) {
      showSnackBar(context, "No goal was deleted");
    }

    int result = await helper.deleteGoal(goal.id);
    if (result != 0) {
      showSnackBar(context, "Goal deleted!");
    } else {
      showSnackBar(context, "Error deleting goal");
    }
  }
}
