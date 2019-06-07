import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:goalkeeper/colors.dart';
import 'package:goalkeeper/my_goal.dart';
import 'package:goalkeeper/database_helper.dart';
import 'package:goalkeeper/public.dart';
import 'package:goalkeeper/about_page.dart';
import 'package:goalkeeper/no_goals.dart';
import 'package:goalkeeper/goal_details.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:sqflite/sqflite.dart';
//import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<MyGoal> goalsList;
  int count = 0;
  void _changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        isThemeCurrentlyDark(context) ? Brightness.light : Brightness.dark);
  } //switch between light & dark modes

  void _delete(BuildContext context, MyGoal goal) async {
    int result = await databaseHelper.deleteGoal(goal.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initDatabase();
    dbFuture.then((database) {
      Future<List<MyGoal>> noteListFuture = databaseHelper.getGoalsList();
      noteListFuture.then((noteList) {
        setState(() {
          this.goalsList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  void navigateToDetail(MyGoal goal, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return GoalDetail(goal, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  Widget buildGoalsList() {
    return Container(
      child: ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int pos) {
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
                          tag: "dartIcon${pos}",
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
                        Text("Goal #$pos+1",
                            style: TextStyle(color: MyColors.accentColor)),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(this.goalsList[pos].title,
                            style: TextStyle(
                                color: invertColors(context),
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0)),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(this.goalsList[pos].body,
                            style: TextStyle(color: invertColors(context))),
                      ],
                    ),
                    Spacer(),
                  ]),
            ),
            onTap: () => navigateToDetail(this.goalsList[pos], 'Edit Note'),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController _myPage = PageController(initialPage: 0);
    if (goalsList == null) {
      goalsList = List<MyGoal>();
      updateListView();
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
          noGoals == true ? buildNoGoals(context) : buildGoalsList(),
          buildAboutPage(context),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
//          createGoal();
          navigateToDetail(MyGoal("", ""), 'Add Note');
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
