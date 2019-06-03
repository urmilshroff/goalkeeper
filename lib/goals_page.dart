import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:goalkeeper/colors.dart';
import 'package:goalkeeper/public.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
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
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0)),
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
                    style:
                        TextStyle(color: invertColors(context), fontSize: 18.0),
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
                    style:
                        TextStyle(color: invertColors(context), fontSize: 18.0),
                    controller: inputGoalBodyController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Goal Description',
                        hintText: 'Explain it in a few words',
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
                      setState(() {
                        goalTitlesList.removeAt(index);
                        goalBodiesList.removeAt(index);
                      });
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
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0)),
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
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/icon/icon.png")))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("${goalTitlesList[index]}",
                      style: TextStyle(
                          color: invertColors(context),
                          fontWeight: FontWeight.w700,
                          fontSize: 26.0)),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("${goalBodiesList[index]}",
                      style: TextStyle(
                          color: invertColors(context), fontSize: 18)),
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
          elevation: 5.0,
        ),
      );
    }));
  }

  Widget _buildGoal(int index) {
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
                                image: AssetImage("assets/icon/icon.png")))),
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
                      style: TextStyle(
                          color: MyColors.accentColor, fontSize: 15.0)),
                  SizedBox(
                    height: 5.0,
                  ),
                  Hero(
                    tag: "goalTitle${index}",
                    child: Text("${goalTitlesList[index]}",
                        style: TextStyle(
                            color: invertColors(context),
                            fontWeight: FontWeight.w700,
                            fontSize: 22.0)),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("${goalBodiesList[index]}",
                      style: TextStyle(
                          color: invertColors(context), fontSize: 15)),
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
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    inputGoalTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: MyColors.primaryColor,
        title: Text('My Goals',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0)),
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
      body: noGoals == true
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
                              fontSize: 18.0, color: invertColors(context))),
                    ),
                  ],
                ),
              ),
            )
          : _buildGoalsList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _createGoal();
        },
        icon: Icon(EvaIcons.plus),
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
