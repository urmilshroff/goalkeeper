import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:goalkeeper/colors.dart';

import 'package:dynamic_theme/dynamic_theme.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  List<String> _goalTitlesList = [];
  List<String> _goalBodiesList = [];
  String inputGoalTitle;
  bool noGoals = true;
  TextEditingController goalController = new TextEditingController();

  bool isThemeCurrentlyDark() {
    if (Theme.of(context).brightness == Brightness.dark) {
      return true; //if currently in dark mode
    } else {
      return false;
    }
  } //returns current theme

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        isThemeCurrentlyDark() ? Brightness.light : Brightness.dark);
  } //switch between light & dark modes

  Color invertColors() {
    if (isThemeCurrentlyDark()) {
      return MyColors.light;
    } else {
      return MyColors.dark;
    }
  } //returns appropriate colors for text visibility

  void _submitForm(String title) {
    if (title.length > 0) {
      setState(() => _goalTitlesList.add(title));
      noGoals = false;
    }
    inputGoalTitle = ""; //resets the title
    Navigator.pop(context);
  }

  void _createNewGoal() {
    Navigator.of(context).push(new CupertinoPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: MyColors.purple,
          title: Text('New Goal',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.0)),
        ),
        body: Form(
          child: new ListView(
            children: <Widget>[
              TextField(
                  controller: goalController,
                onSubmitted: (title) {
                  inputGoalTitle = title;
                  _submitForm(title);
                },
                decoration: new InputDecoration(
                    hintText: 'Enter Goal Title',
                    contentPadding: const EdgeInsets.all(10.0)),
              ),
//                TextField(
//                onSubmitted: (body) {
//                  if (body.length > 0) {
//                    setState(() => _goalBodiesList.add(body));
//                  }
//                  Navigator.pop(context);
//                },
//                decoration: new InputDecoration(
//                    hintText: 'Enter Goal Body',
//                    contentPadding: const EdgeInsets.all(10.0)),
//              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _submitForm(goalController.text);
          },
          child: Icon(Icons.check),
          foregroundColor: MyColors.light,
          backgroundColor: MyColors.pink,
          elevation: 5.0,
        ),
      );
    }));
  } //user creates a new goal

  void _deleteGoal(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Done with \'${_goalTitlesList[index]}\'?"),
              content: Text("This goal will be deleted!"),
              actions: <Widget>[
                FlatButton(
                    child:
                        Text('CANCEL', style: TextStyle(color: invertColors())),
                    onPressed: () => Navigator.of(context).pop()),
                FlatButton(
                    child:
                        Text('DELETE', style: TextStyle(color: MyColors.red)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      setState(() => _goalTitlesList.removeAt(index));
                      _goalTitlesList.isEmpty == true
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
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.0)),
        ),
        body: _buildTile(
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Hero(
                        tag: "goalTitle${index}",
                        child: Text("${_goalTitlesList[index]}",
                            style: TextStyle(
                                color: invertColors(),
                                fontWeight: FontWeight.w700,
                                fontSize: 22.0)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${_goalTitlesList[index]}",
                          style:
                              TextStyle(color: invertColors(), fontSize: 15)),
                    ],
                  ),
                ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _deleteGoal(index);
          },
          child: Icon(Icons.delete),
          foregroundColor: MyColors.light,
          backgroundColor: MyColors.red,
          elevation: 5.0,
        ),
      );
    }));
  }

  Widget _buildNewGoal(int index) {
    int goalNumber = index + 1;
    return
//        Hero(
//      tag: "card${index}",
        _buildTile(
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Goal #$goalNumber",
                      style: TextStyle(
                          color: MyColors.accentColor, fontSize: 15.0)),
                  SizedBox(
                    height: 5,
                  ),
                  Hero(
                    tag: "goalTitle${index}",
                    child: Text("${_goalTitlesList[index]}",
                        style: TextStyle(
                            color: invertColors(),
                            fontWeight: FontWeight.w700,
                            fontSize: 22.0)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${_goalTitlesList[index]}",
                      style: TextStyle(color: invertColors(), fontSize: 15)),
                ],
              ),
            ]),
      ),
//      onTap: () => _deleteGoalConfirmation(index),
      onTap: () => _editGoal(index),
    );
  } //flutter builds a new goal

  Widget _buildGoalsList() {
    return Container(
      child: ListView.builder(itemBuilder: (context, index) {
        if (index < _goalTitlesList.length) {
          return _buildNewGoal(index);
        }
      }),
    );
  } //builds goals list

  Widget _buildTile(Widget widgetContent, {Function() onTap}) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10.0),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: MyColors.primaryColor,
        title: Text('My Goals',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24.0)),
        actions: <Widget>[
          IconButton(
            icon: isThemeCurrentlyDark()
                ? Icon(Icons.brightness_7) //use sun icon
                : Icon(Icons.brightness_2), //use moon icon
            tooltip: isThemeCurrentlyDark()
                ? "Switch to light mode"
                : "Switch to dark mode",
            onPressed: changeBrightness,
          ),
        ],
      ),
      body: noGoals == true
          ? Center(
              child: Text("No goals yet",
                  style: TextStyle(
                      color: invertColors(),
                      fontSize: 24.0)))
          : _buildGoalsList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _createNewGoal();
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
