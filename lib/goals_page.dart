import 'package:flutter/material.dart';
import 'package:goalkeeper/colors.dart';

import 'package:dynamic_theme/dynamic_theme.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  List<String> _goalTitlesList = [];
  List<String> _goalBodiesList = [];

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

  void _createNewGoal() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
        elevation: 5.0,
        backgroundColor: MyColors.primaryColor,
        title: Text('New Goal',
            style: TextStyle(
                color: MyColors.light,
                fontWeight: FontWeight.w700,
                fontSize: 24.0)),
      ),
        body: Form(
          child: new ListView(
            children: <Widget>[
              TextField(
                onSubmitted: (title) {
                  if (title.length > 0) {
                    setState(() => _goalTitlesList.add(title));
                  }
                  Navigator.pop(context);
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
      );
    }));
  } //user creates a new goal

  Widget _buildNewGoal(int goalNumber, String goalTitle, String goalBody) {
    return _buildTile(
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
                  Text("$goalTitle",
                      style: TextStyle(
                          color: invertColors(),
                          fontWeight: FontWeight.w700,
                          fontSize: 22.0)),
                  SizedBox(
                    height: 5,
                  ),
                  Text("$goalBody",
                      style: TextStyle(color: invertColors(), fontSize: 15)),
                ],
              ),
            ]),
      ),
    );
  } //flutter builds a new goal

  Widget _buildGoalsList() {
    return Container(
      child: ListView.builder(itemBuilder: (context, index) {
        if (index < _goalTitlesList.length) {
          return _buildNewGoal(
              index, _goalTitlesList[index], "Goal body goes here");
        }
      }),
    );
  } //builds goals list

  Widget _buildTile(Widget widgetStuff, {Function() onTapAction}) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            onTap: onTapAction != null
                ? () => onTapAction()
                : () {
                    print("Nothing set");
                  },
            child: widgetStuff,
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
                color: MyColors.light,
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
      body: _buildGoalsList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _createNewGoal();
        },
        icon: Icon(Icons.add),
        label: Text("NEW GOAL"),
        foregroundColor: MyColors.light,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 5.0,
      ),
    );
  }
}
