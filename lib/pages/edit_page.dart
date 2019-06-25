import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
        backgroundColor: MyColors.green,
        title: Text("Edit Goal",
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
                  tag: "dartIcon${goal.id}",
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
                          fontSize: 22.0)),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(
                    color: invertColors(context),
                  ),
                  controller: inputGoalTitleController,
                  onChanged: (title) {
                    updateTitle();
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: invertColors(context)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColors.green),
                      ),
                      border: OutlineInputBorder(),
                      hintText: "Goal Title",
                      hintStyle: TextStyle(
                        color: invertColors(context),
                      ),
                      contentPadding: const EdgeInsets.all(15.0)),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(
                    color: invertColors(context),
                  ),
                  controller: inputGoalBodyController,
                  onChanged: (body) {
                    updateBody();
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: invertColors(context)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColors.green),
                      ),
                      border: OutlineInputBorder(),
                      hintText: "Description",
                      hintStyle: TextStyle(
                        color: invertColors(context),
                      ),
                      contentPadding: const EdgeInsets.all(15.0)),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        heroTag: "fab",
        closeManually: false,
        foregroundColor: MyColors.light,
        backgroundColor: MyColors.pink,
        elevation: 3.0,
        children: [
          SpeedDialChild(
              child: Icon(Icons.save),
              foregroundColor: MyColors.light,
              backgroundColor: MyColors.blue,
              label: "Save",
              labelStyle:
                  TextStyle(color: MyColors.dark, fontWeight: FontWeight.w500),
              onTap: () => saveGoal()),
          SpeedDialChild(
              child: Icon(Icons.delete_forever),
              foregroundColor: MyColors.light,
              backgroundColor: MyColors.red,
              label: "Delete",
              labelStyle:
                  TextStyle(color: MyColors.dark, fontWeight: FontWeight.w500),
              onTap: () => deleteGoal()),
        ],
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

  void deleteGoal() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Done with \'${goal.title}\'?",
                  style: TextStyle(
                      color: invertColors(context),
                      fontWeight: FontWeight.w600)),
              content: Text("This goal will be deleted!",
                  style: TextStyle(
                    color: invertColors(context),
                  )),
              actions: <Widget>[
                FlatButton(
                    child: Text('CANCEL',
                        style: TextStyle(
                            color: invertColors(context),
                            fontWeight: FontWeight.w500)),
                    onPressed: () => Navigator.of(context).pop()),
                FlatButton(
                    child: Text('DELETE',
                        style: TextStyle(
                            color: MyColors.red, fontWeight: FontWeight.w500)),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      await helper.deleteGoal(goal.id);
                    })
              ]);
        });
  }
}
