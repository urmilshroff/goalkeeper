import 'package:flutter/material.dart';
import 'package:goalkeeper/colors.dart';

import 'package:dynamic_theme/dynamic_theme.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  List<String> _goalsList = [];

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
          appBar: AppBar(title: Text("New Goal")),
          body: TextField(
            onSubmitted: (val) {
              if (val.length > 0) {
                setState(() => _goalsList.add(val));
              }
              Navigator.pop(context);
            },
            decoration: new InputDecoration(
                hintText: 'Enter new goal',
                contentPadding: const EdgeInsets.all(10.0)),
          ));
    }));
  } //user creates a new goal

  Widget _buildNewGoal(String index) {
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
                  Text("$index",
                      style: TextStyle(
                          color: MyColors.accentColor, fontSize: 15.0)),
                  SizedBox(
                    height: 5,
                  ),
                  Text("$index",
                      style: TextStyle(
                          color: invertColors(),
                          fontWeight: FontWeight.w700,
                          fontSize: 22.0)),
                  SizedBox(
                    height: 5,
                  ),
                  Text("$index",
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
        if (index < _goalsList.length) {
          return _buildNewGoal(_goalsList[index]);
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
        title: Text('Goals',
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
