import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:goalkeeper/main.dart';
import 'package:goalkeeper/colors.dart';
import 'package:goalkeeper/goals_page.dart';
import 'package:goalkeeper/new_goal.dart';

void editGoal(int index, BuildContext context) {
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
                              image: AssetImage("img/icon.png")))),
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
                Text("Goal description",
                    style:
                        TextStyle(color: invertColors(context), fontSize: 18)),
              ],
            ),
          ])),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteGoal(index, context);
        },
        child: Icon(Icons.delete),
        foregroundColor: MyColors.light,
        backgroundColor: MyColors.red,
        elevation: 5.0,
      ),
    );
  }));
}

void deleteGoal(int index, BuildContext context) {
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
                  child: Text('DELETE', style: TextStyle(color: MyColors.red)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
//                      setState(() => goalTitlesList.removeAt(index));
                    goalTitlesList.isEmpty == true
                        ? noGoals = true
                        : noGoals = false;
                  })
            ]);
      });
}
