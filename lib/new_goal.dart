import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:goalkeeper/main.dart';
import 'package:goalkeeper/colors.dart';
import 'package:goalkeeper/goals_page.dart';
import 'package:goalkeeper/edit_goal.dart';

void createNewGoal(BuildContext context) {
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
                  onSubmitted: (title) {
                    inputGoalTitle = title;
                    submitForm(inputGoalTitle, context);
                  },
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
                  // controller: inputGoalTitleController,
                  // onSubmitted: (title) {
                  //   inputGoalTitle = title;
                  //   submitForm(inputGoalTitle);
                  // },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
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
          submitForm(inputGoalTitleController.text, context);
        },
        child: Icon(Icons.check),
        foregroundColor: MyColors.light,
        backgroundColor: MyColors.pink,
        elevation: 5.0,
      ),
    );
  }));
} //user creates a new goal

void submitForm(String title, BuildContext context) {
  if (title.length > 0) {
//      setState(() => goalTitlesList.add(title));
    noGoals = false;
  }
  inputGoalTitle = ""; //resets the title
  Navigator.pop(context);
}

Widget buildNewGoal(int index, BuildContext context) {
  int goalNumber = index + 1;
  return buildTile(
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
                              image: AssetImage("img/icon.png")))),
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
                    style:
                        TextStyle(color: MyColors.accentColor, fontSize: 15.0)),
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
                Text("Goal description",
                    style:
                        TextStyle(color: invertColors(context), fontSize: 15)),
              ],
            ),
            Spacer(),
          ]),
    ),
    onTap: () => editGoal(index, context),
  );
} //flutter builds a new goal
