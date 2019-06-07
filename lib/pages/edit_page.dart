import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:goalkeeper/utils/colors.dart';
import 'package:goalkeeper/utils/database_helper.dart';
import 'package:goalkeeper/utils/goal.dart';
import 'package:goalkeeper/utils/public.dart';

class EditGoal extends StatefulWidget {
  final GoalClass goal;

  EditGoal(this.goal); //constructor

  @override
  State<StatefulWidget> createState() {
    return EditGoalState(this.goal);
  }
}

class EditGoalState extends State<EditGoal> {
  DatabaseHelper helper = DatabaseHelper();

  GoalClass goal;

  TextEditingController inputGoalTitleController = TextEditingController();
  TextEditingController inputGoalBodyController = TextEditingController();

  EditGoalState(this.goal);

  @override
  Widget build(BuildContext context) {
    inputGoalTitleController.text = goal.title;
    inputGoalBodyController.text = goal.body;

    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: MyColors.aqua,
        title: Text('Edit Goal',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0)),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                Hero(
                  tag: "dartIcon${this.goal.id - 1}",
                  child: Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icon.png")))),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Text("Edit Goal",
                      style: TextStyle(
                          color: invertColors(context),
                          fontWeight: FontWeight.w700,
                          fontSize: 26.0)),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(color: invertColors(context)),
                  controller: inputGoalTitleController,
                  onChanged: (title) {
                    updateTitle();
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Goal Title",
                      contentPadding: const EdgeInsets.all(15.0)),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(color: invertColors(context)),
                  controller: inputGoalBodyController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Description",
                      contentPadding: const EdgeInsets.all(15.0)),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveGoal();
        },
        child: Icon(EvaIcons.checkmark),
        foregroundColor: MyColors.light,
        backgroundColor: MyColors.pink,
        elevation: 3.0,
      ),
    );
  }

  void updateTitle() {
    goal.title = inputGoalTitleController.text;
  }

  void updateBody() {
    goal.body = inputGoalBodyController.text;
  }

  void saveGoal() async {
    int result;

    Navigator.pop(context);

    if (goal.title.length > 0) {
      if (goal.id == null) {
        result = await helper.createGoal(goal);
      } else {
        result = await helper.updateGoal(goal);
      }
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
