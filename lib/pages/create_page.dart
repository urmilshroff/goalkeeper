import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "package:goalkeeper/utils/colors.dart";
import "package:goalkeeper/utils/database_helper.dart";
import "package:goalkeeper/utils/goal.dart";
import "package:goalkeeper/utils/public.dart";

class CreateGoal extends StatefulWidget {
  final GoalClass goal;

  CreateGoal(this.goal); //constructor

  @override
  State<StatefulWidget> createState() {
    return CreateGoalState(this.goal);
  }
}

class CreateGoalState extends State<CreateGoal> {
  DatabaseHelper helper = DatabaseHelper();

  GoalClass goal;

  TextEditingController inputGoalTitleController = TextEditingController();
  TextEditingController inputGoalBodyController = TextEditingController();

  CreateGoalState(this.goal);

  @override
  Widget build(BuildContext context) {
print("dartIcon${goal.id}");
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: MyColors.purple,
        title: Text("New Goal",
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
                  tag: "",
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
                  child: Text("New Goal",
                      style: TextStyle(
                          color: invertColors(context),
                          fontWeight: FontWeight.w700,
                          fontSize: 22.0)),
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
                      labelText: "Goal Title",
                      hintText: "What\'s your goal for today?",
                      contentPadding: const EdgeInsets.all(15.0)),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(color: invertColors(context)),
                  controller: inputGoalBodyController,
                  onChanged: (body) {
                    updateBody();
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Description",
                      hintText: "Explain it in a few words",
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
        child: Icon(Icons.check),
        foregroundColor: MyColors.light,
        backgroundColor: MyColors.green,
        elevation: 3.0,
        heroTag: "fab",
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
    Navigator.pop(context);
    if (goal.title.length > 0) {
      if (goal.id == null) {
        await helper.createGoal(goal);
        showSnackBar(context, "Goal created!");
      } else {
        await helper.updateGoal(goal);
        showSnackBar(context, "Goal updated!");
      }
    }
  }
}
