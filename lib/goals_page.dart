import 'package:flutter/material.dart';
import 'package:goalkeeper/colors.dart';
import 'package:goalkeeper/new_goal.dart';
import 'package:goalkeeper/route_transitions.dart';

import 'package:dynamic_theme/dynamic_theme.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  bool showNewGoalAlert = false;

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  Color invertColors() {
    if (Theme.of(context).brightness == Brightness.light) {
      return MyColors.dark;
    } else if (Theme.of(context).brightness == Brightness.dark) {
      return MyColors.light;
    }
  }

  _createNewGoal(BuildContext context) async {
      var goalDetails = new List();
    goalDetails = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewGoal()),
    );

    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$goalDetails[0]")));
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
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 100.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: 4.0),
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: _buildTile(
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
                                  Text("Welcome!",
                                      style: TextStyle(
                                          color: invertColors(),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22.0)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Start by creating a new goal below.",
                                      style: TextStyle(
                                          color: invertColors(), fontSize: 15)),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ),
                  showNewGoalAlert == true
                      ? AlertDialog(
                          title: Text("ALERT BITCHES"),
                        )
                      : Text("NO ALERT"),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RaisedButton(
                      padding: const EdgeInsets.all(1.0),
                      onPressed: changeBrightness,
                      color: MyColors.primaryColor,
                      splashColor: invertColors(),
                      child: Text("LIGHTS"),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
            _createNewGoal(context);
//          if (showNewGoalAlert == true) {
//            setState(() {
//              showNewGoalAlert = false;
//            });
//          } else if (showNewGoalAlert == false) {
//            setState(() {
//              showNewGoalAlert = true;
//            });
//          }
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => NewGoal()),
//          );
//          Navigator.push(context, SizeRoute(page: NewGoal()));
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

Widget _buildTile(Widget widgetStuff, {Function() onTapAction}) {
  return Material(
      elevation: 7.5,
      borderRadius: BorderRadius.circular(10.0),
      shadowColor: MyColors.light,
      child: InkWell(
        onTap: onTapAction != null
            ? () => onTapAction()
            : () {
                print("Nothing set");
              },
        child: widgetStuff,
        splashColor: MyColors.light,
      ));
}
