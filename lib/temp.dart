import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:goalkeeper/utils/colors.dart';
import 'package:goalkeeper/utils/goal.dart';
import 'package:goalkeeper/utils/database_helper.dart';
import 'package:goalkeeper/utils/public.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

bool noGoals = true;

List<String> goalTitlesList = [];
List<String> goalBodiesList = [];

TextEditingController inputGoalTitleController = new TextEditingController();
TextEditingController inputGoalBodyController = new TextEditingController();

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<GoalClass> goalsList;
  int count = 0;

  void _changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        isThemeCurrentlyDark(context) ? Brightness.light : Brightness.dark);
  } //switch between light & dark modes

  void _submitForm(String inputGoalTitle, String inputGoalBody) {
    if (inputGoalTitle.length > 0 && inputGoalBody.length > 0) {
      setState(() {
        goalTitlesList.add(inputGoalTitle);
        goalBodiesList.add(inputGoalBody);
      });
      noGoals = false;
    }
    inputGoalTitleController.text = ""; //resets the title
    inputGoalBodyController.text = ""; //resets the description
    Navigator.pop(context);
  }

  void _createGoal() {
    Navigator.of(context).push(new CupertinoPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: MyColors.purple,
          title: Text('New Goal',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0)),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(color: invertColors(context)),
                    controller: inputGoalTitleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Goal Title',
                        hintText: 'What\'s your goal for today?',
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
                        labelText: 'Goal Description',
                        hintText: 'Explain it in a few titles',
                        contentPadding: const EdgeInsets.all(15.0)),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _submitForm(
                inputGoalTitleController.text, inputGoalBodyController.text);
          },
          child: Icon(EvaIcons.checkmark),
          foregroundColor: MyColors.light,
          backgroundColor: MyColors.pink,
          elevation: 3.0,
        ),
      );
    }));
  } //user creates a new goal

//  void _deleteGoalFromDB(BuildContext context, MyGoal goal) async {
//      int result = await databaseHelper.deleteGoal(goal._id);
//      }

  void _deleteGoal(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Done with \'${goalTitlesList[index]}\'?"),
              content: Text("This goal will be deleted!"),
              actions: <Widget>[
                FlatButton(
                    child: Text('CANCEL',
                        style: TextStyle(color: invertColors(context))),
                    onPressed: () => Navigator.of(context).pop()),
                FlatButton(
                    child:
                        Text('DELETE', style: TextStyle(color: MyColors.red)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
//                      setState(() {
//                        goalTitlesList.removeAt(index);
//                        goalBodiesList.removeAt(index);
//                      });

                      goalTitlesList.isEmpty == true
                          ? noGoals = true
                          : noGoals = false;
                    })
              ]);
        });
  }

  void _editGoal(int index) {
    Navigator.of(context).push(new CupertinoPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: MyColors.aqua,
          title: Text('Edit Goal',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0)),
        ),
        body: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 100.0,
                  ),
                  Hero(
                    tag: "dartIcon${index}",
                    child: Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/icon.png")))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("${goalTitlesList[index]}",
                      style: TextStyle(
                          color: invertColors(context),
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0)),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("${goalBodiesList[index]}",
                      style: TextStyle(
                          color: invertColors(context), fontSize: 16.0)),
                ],
              ),
            ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _deleteGoal(index);
          },
          child: Icon(EvaIcons.trash),
          foregroundColor: MyColors.light,
          backgroundColor: MyColors.red,
          elevation: 3.0,
        ),
      );
    }));
  }

  Widget _buildGoal(index) {
    int goalNumber = index + 1;
    return _buildTile(
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Hero(
                    tag: "dartIcon${index}",
                    child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/icon.png")))),
                  ),
                ],
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Goal #$goalNumber",
                      style: TextStyle(color: MyColors.accentColor)),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(this.goalsList[index].title,
                      style: TextStyle(
                          color: invertColors(context),
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0)),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(this.goalsList[index].body,
                      style: TextStyle(color: invertColors(context))),
                ],
              ),
              Spacer(),
            ]),
      ),
      onTap: () => _editGoal(index),
    );
  } //flutter builds a new goal

  Widget _buildGoalsList() {
    return Container(
      child: ListView.builder(itemBuilder: (context, index) {
        if (index < goalTitlesList.length) {
          return _buildGoal(index);
        }
      }),
    );
  } //builds goals list

  Widget _buildAboutPage() {
    return Container(
      child: ListView(
        children: <Widget>[
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/urmil-vector.png")))),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text("Made by",
                          style: TextStyle(color: invertColors(context))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text("Urmil Shroff",
                          style: TextStyle(
                              color: invertColors(context),
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0)),
                    ),
                  ]),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text("View on",
                          style: TextStyle(color: invertColors(context))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text("Twiter | GitHub | Website",
                          style: TextStyle(
                            color: invertColors(context),
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(Widget widgetContent, {Function() onTap}) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print("Nothing set");
                  },
            child: widgetContent,
            splashColor: MyColors.accentColor,
          )),
    );
  } //build material goal card

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    inputGoalTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PageController _myPage = PageController(initialPage: 0);

    if (goalsList == null) {
      goalsList = List<GoalClass>();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: MyColors.primaryColor,
        title: Text('My Goals',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0)),
        actions: <Widget>[
          IconButton(
            icon: isThemeCurrentlyDark(context)
                ? Icon(EvaIcons.sun) //use sun icon
                : Icon(EvaIcons.moon), //use moon icon
            tooltip: isThemeCurrentlyDark(context)
                ? "Switch to light mode"
                : "Switch to dark mode",
            onPressed: _changeBrightness,
          ),
        ],
      ),
      body: PageView(
        controller: _myPage,
        children: <Widget>[
          noGoals == true
              ? Container(
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
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: invertColors(context))),
                        ),
                      ],
                    ),
                  ),
                )
              : _buildGoalsList(),
          _buildAboutPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createGoal();
        },
        child: Icon(EvaIcons.plus),
        foregroundColor: MyColors.light,
        backgroundColor: MyColors.accentColor,
        elevation: 3.0,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 15.0,
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                EvaIcons.home,
                size: 26,
              ),
              color: invertColors(context),
              onPressed: () {
                _myPage.jumpToPage(0);
              },
            ),
            IconButton(
              icon: Icon(
                EvaIcons.info,
                size: 26,
              ),
              color: invertColors(context),
              onPressed: () {
                _myPage.jumpToPage(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}






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
