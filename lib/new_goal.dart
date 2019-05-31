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

  @override
  Widget build(BuildContext context) {
      Scaffold(
          appBar: new AppBar(title: new Text('Add a new task')),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
//              _createNewGoal(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
      }
}
