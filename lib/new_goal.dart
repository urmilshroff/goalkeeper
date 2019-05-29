import 'package:flutter/material.dart';
import 'package:goalkeeper/colors.dart';
import 'package:goalkeeper/goals_page.dart';
import 'package:goalkeeper/route_transitions.dart';

import 'package:dynamic_theme/dynamic_theme.dart';

class NewGoal extends StatefulWidget {
  @override
  _NewGoalState createState() => _NewGoalState();
}

class _NewGoalState extends State<NewGoal> {
  var goalDetails = new List();
  Color invertColors() {
    if (Theme.of(context).brightness == Brightness.light) {
      return MyColors.dark;
    } else if (Theme.of(context).brightness == Brightness.dark) {
      return MyColors.light;
    }
  }

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
        ),
        body: new Container(
            child: new Form(
          child: new ListView(
            children: <Widget>[
              new TextFormField(
                onSaved: (String value) {
                  goalDetails.add(value);
                },
              ),
              new TextFormField(
                onSaved: (String value) {
                  goalDetails.add(value);
                },
              ),
              new Container(
                child: new RaisedButton(
                  child: new Text(
                    'SEND DATA',
                  ),
                  onPressed: () {
                    Navigator.pop(context, goalDetails);
                  },
                ),
              )
            ],
          ),
        )));
  }
}
