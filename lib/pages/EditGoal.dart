import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:goalkeeper/Models/Goal.dart';
import 'package:goalkeeper/Services/Interfaces/IRepository.dart';
import 'package:goalkeeper/Services/NotificationCenter.dart';
import 'package:goalkeeper/Utils/HelperUtils.dart';
import 'package:goalkeeper/Utils/ThemeUtils.dart';
import 'package:goalkeeper/Utils/colors.dart';
import 'package:goalkeeper/Utils/pickers.dart';

class EditGoal extends StatefulWidget {
  final Goal goal;
  final NotificationCenter notificationCenter;
  final IRepository repository;

  EditGoal(this.goal,
      {@required this.repository,
      @required this.notificationCenter}); //constructor

  @override
  State<StatefulWidget> createState() {
    return EditGoalState(this.goal, this.notificationCenter, this.repository);
  }
}

class EditGoalState extends State<EditGoal> {
  final IRepository repository;
  final NotificationCenter notificationCenter;

  Goal goal;
  Color invertColor;

  TextEditingController _bodyTextController;
  TextEditingController _titleTextController;

  EditGoalState(this.goal, this.notificationCenter, this.repository) {
    this._titleTextController =
        new TextEditingController(text: this.goal.title);
    this._bodyTextController = new TextEditingController(text: this.goal.body);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.invertColor = invertColors(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: MyColors.green,
        title: Text(
          'Edit Goal',
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
                  tag: 'dartIcon${goal.id}',
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icon.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Text(
                    'Edit Goal',
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
                  controller: this._titleTextController,
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
                      borderSide: BorderSide(color: MyColors.green),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Goal Title',
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
                  controller: this._bodyTextController,
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
                      borderSide: BorderSide(color: MyColors.green),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Description',
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
                            ? 'ADD DEADLINE'
                            : 'EDIT DEADLINE',
                        style: TextStyle(
                          color: this.invertColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        this.editDeadLine(context);
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
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        heroTag: 'fab',
        closeManually: false,
        foregroundColor: MyColors.light,
        backgroundColor: MyColors.pink,
        elevation: 3.0,
        children: [
          SpeedDialChild(
            child: Icon(Icons.save),
            foregroundColor: MyColors.light,
            backgroundColor: MyColors.blue,
            label: 'Save',
            labelStyle:
                TextStyle(color: MyColors.dark, fontWeight: FontWeight.w500),
            onTap: this.saveGoal,
          ),
          SpeedDialChild(
            child: Icon(Icons.delete_forever),
            foregroundColor: MyColors.light,
            backgroundColor: MyColors.red,
            label: 'Delete',
            labelStyle:
                TextStyle(color: MyColors.dark, fontWeight: FontWeight.w500),
            onTap: this.deleteGoal,
          ),
        ],
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
        repository.insert(goal);
      } else {
        repository.update(goal);
      }
    }

    notificationCenter.updateGoalNotification(goal);
  }

  void deleteGoal() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(
            'Done with \'${goal.title}\'?',
            style:
                TextStyle(color: this.invertColor, fontWeight: FontWeight.w600),
          ),
          content: Text(
            'This goal will be deleted!',
            style: TextStyle(
              color: this.invertColor,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'CANCEL',
                style: TextStyle(
                    color: this.invertColor, fontWeight: FontWeight.w500),
              ),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text(
                'DELETE',
                style:
                    TextStyle(color: MyColors.red, fontWeight: FontWeight.w500),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                repository.delete(goal);
              },
            ),
          ],
        );
      },
    );
  }

  void editDeadLine(context) async {
    DateTime dueDate = await pickDate(context);
    if (dueDate == null) return;

    TimeOfDay dueTime = await pickTime(context);
    if (dueTime == null) return;

    DateTime deadLine = DateTime(
        dueDate.year, dueDate.month, dueDate.day, dueTime.hour, dueTime.minute);

    setState(() {
      goal.deadLine = deadLine;
    });

    showSnackBar(context, 'Deadline set for ${getFormattedDate(deadLine)}!');
  }
}
