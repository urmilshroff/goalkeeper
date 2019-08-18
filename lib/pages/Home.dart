import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goalkeeper/Services/Interfaces/IRepository.dart';
import 'package:goalkeeper/Services/Navigation.dart';
import 'package:goalkeeper/Widgets/BuildTile.dart';
import 'package:goalkeeper/Widgets/EmptyPage.dart';
import 'package:goalkeeper/Pages/About.dart';
import 'package:goalkeeper/Utils/HelperUtils.dart';
import 'package:goalkeeper/Utils/colors.dart';
import 'package:goalkeeper/Utils/ThemeUtils.dart';
import 'package:goalkeeper/Models/Goal.dart';

class Home extends StatefulWidget {
  final IRepository repository;

  Home({@required this.repository});

  @override
  _HomeState createState() => _HomeState(repository: this.repository);
}

class _HomeState extends State<Home> {
  final IRepository repository;
  ScrollController _scrollController = ScrollController(keepScrollOffset: true);
  PageController _myPage = PageController(initialPage: 0);
  Future<List<Goal>> goalListPromise;

  _HomeState({@required this.repository});
  @override
  void initState() {
    super.initState();
    this.goalListPromise = repository.getGoalsList();
  }

  void toggleBrightness() {
    DynamicTheme.of(context).setBrightness(
      getInvertTheme(context),
    );
  }

  Widget buildGoalsListPage() {
    return FutureBuilder(
      future: this.goalListPromise,
      builder: (BuildContext context, AsyncSnapshot<List<Goal>> goals) {
        if (goals.hasError)
          showSnackBar(context, goals.error.toString());
        else if (goals.connectionState == ConnectionState.done)
          return (goals.hasData && goals.data.isNotEmpty
              ? buildGoalsList(goals.data)
              : EmptyPage());
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildGoalsList(List<Goal> goals) {
    double _width = MediaQuery.of(context).size.width * 0.75;

    return Container(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        itemCount: goals.length,
        controller: this._scrollController,
        itemBuilder: (BuildContext context, int index) {
          var goal = goals[index];

          return BuildTile(
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Hero(
                        tag: "dartIcon${goal.id}",
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/icon.png"),
                            ),
                          ),
                        ),
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
                      Container(
                        width: _width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Goal #${goal.id}",
                              style: TextStyle(
                                color: MyColors.accentColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            goal.deadLine != null
                                ? Row(
                                    children: <Widget>[
                                      Icon(
                                        EvaIcons.clockOutline,
                                        size: 16,
                                        color: MyColors.accentColor,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        getFormattedDate(goal.deadLine),
                                        style: TextStyle(
                                            color: MyColors.accentColor),
                                      )
                                    ],
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Container(
                        width: _width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              goal.title,
                              style: TextStyle(
                                  color: invertColors(context),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Text(
                              goal.body,
                              style: TextStyle(
                                  color: invertColors(context), fontSize: 16.0),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
            onTap: () => goToEditGoal(context, goal),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = isThemeCurrentlyDark(context);
    Icon actionIcon = isDarkTheme ? Icon(EvaIcons.sun) : Icon(EvaIcons.moon);
    String toolTip = isDarkTheme ? "BURN YOUR EYES" : "SAVE YOUR EYES";

    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: MyColors.primaryColor,
        title: Text(
          "My Goals",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0),
        ),
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            tooltip: toolTip,
            onPressed: toggleBrightness,
          ),
        ],
      ),
      body: PageView(
        controller: _myPage,
        children: <Widget>[
          buildGoalsListPage(),
          buildAboutPage(context),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToCreateGoal(context);
        },
        child: Icon(Icons.add),
        foregroundColor: MyColors.light,
        backgroundColor: MyColors.accentColor,
        elevation: 3.0,
        heroTag: "fab",
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
                _myPage.animateToPage(
                  0,
                  curve: Curves.easeOut,
                  duration: Duration(milliseconds: 300),
                );
              },
            ),
            IconButton(
              icon: Icon(
                EvaIcons.info,
                size: 26,
              ),
              color: invertColors(context),
              onPressed: () {
                _myPage.animateToPage(
                  1,
                  curve: Curves.easeOut,
                  duration: Duration(milliseconds: 300),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
