import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:goalkeeper/Models/Goal.dart';
import 'package:goalkeeper/Services/GoalsRepository.dart';
import 'package:goalkeeper/Services/NotificationCenter.dart';
import 'package:goalkeeper/Utils/HelperUtils.dart';
import 'package:goalkeeper/Utils/ThemeUtils.dart';
import "package:goalkeeper/Utils/colors.dart";
import "package:goalkeeper/Utils/pickers.dart";

class CreateGoal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateGoalState();
  }
}

class CreateGoalState extends State<CreateGoal> {
  GoalsRepository repo = GoalsRepository();

  Goal goal = new Goal("", "");
  Color invertColor;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: MyColors.purple,
        title: Text(
          "New Goal",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0),
        ),
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
                        image: AssetImage("assets/icon.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Text(
                    "New Goal",
                    style: TextStyle(
                        color: this.invertColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 22.0),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(
                    color: this.invertColor,
                  ),
                  onChanged: this.updateTitle,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: this.invertColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.purple),
                    ),
                    border: OutlineInputBorder(),
                    labelText: "Goal Title",
                    hintText: "What\'s your goal for today?",
                    labelStyle: TextStyle(
                      color: this.invertColor,
                    ),
                    hintStyle: TextStyle(
                      color: this.invertColor,
                    ),
                    contentPadding: const EdgeInsets.all(15.0),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(
                    color: this.invertColor,
                  ),
                  onChanged: this.updateBody,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: this.invertColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.purple),
                    ),
                    border: OutlineInputBorder(),
                    labelText: "Description",
                    hintText: "Explain it in a few words",
                    labelStyle: TextStyle(
                      color: this.invertColor,
                    ),
                    hintStyle: TextStyle(
                      color: this.invertColor,
                    ),
                    contentPadding: const EdgeInsets.all(15.0),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                      primaryColor: MyColors.purple,
                      accentColor: MyColors.yellow),
                  child: Builder(
                    builder: (context) => OutlineButton(
                      child: Text(
                        goal.deadLine == null
                            ? "ADD DEADLINE"
                            : "EDIT DEADLINE",
                        style: TextStyle(
                          color: this.invertColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        createNewDeadline(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      borderSide: BorderSide(color: MyColors.purple),
                      highlightedBorderColor: MyColors.yellow,
                      splashColor: MyColors.yellow,
                    ),
                  ),
                )
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
        backgroundColor: MyColors.yellow,
        elevation: 3.0,
        heroTag: "fab",
      ),
    );
  }

  void updateTitle(String newTitle) {
    this.setState(() {
      goal.title = newTitle;
    });
  }

  void updateBody(String newBody) {
    this.setState(() {
      goal.body = newBody;
    });
  }

  void saveGoal() async {
    Navigator.pop(context);
    if (goal.title.trim().isNotEmpty) {
      if (goal.id == null) {
        repo.insert(goal);
      } else {
        repo.update(goal);
      }
      var noty = NotificationCenter();
      noty.scheduleNotification(goal);
    }
  }

  void createNewDeadline(context) async {
    DateTime dueDate = await pickDate(context);
    if (dueDate == null) return;

    TimeOfDay dueTime = await pickTime(context);
    if (dueTime == null) return;

    DateTime deadLine = DateTime(
        dueDate.year, dueDate.month, dueDate.day, dueTime.hour, dueTime.minute);

    showSnackBar(context, "Deadline set for ${getFormattedDate(deadLine)}!");

    setState(() {
      goal.deadLine = deadLine;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.invertColor = invertColors(context);
  }
}
