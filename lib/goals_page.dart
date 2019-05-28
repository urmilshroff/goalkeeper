import 'package:flutter/material.dart';
import 'package:goalkeeper/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
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
                fontSize: 28.0)),
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Goalkeeper",
                            style:
                                TextStyle(color: MyColors.blue, fontSize: 18)),
                        Text("Hello, World!",
                            style: TextStyle(
                                color: MyColors.dark,
                                fontWeight: FontWeight.w700,
                                fontSize: 30.0))
                      ],
                    ),
                    Material(
                        color: MyColors.blue,
                        borderRadius: BorderRadius.circular(50.0),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(Icons.check_circle,
                              color: MyColors.light, size: 40.0),
                        )))
                  ]),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Goalkeeper",
                            style: TextStyle(
                                color: MyColors.yellow, fontSize: 18)),
                        Text("Hello, World!",
                            style: TextStyle(
                                color: MyColors.dark,
                                fontWeight: FontWeight.w700,
                                fontSize: 30.0))
                      ],
                    ),
                    Material(
                        color: MyColors.yellow,
                        borderRadius: BorderRadius.circular(50.0),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(Icons.check_circle,
                              color: MyColors.light, size: 40.0),
                        )))
                  ]),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Goalkeeper",
                            style:
                                TextStyle(color: MyColors.aqua, fontSize: 18)),
                        Text("Hello, World!",
                            style: TextStyle(
                                color: MyColors.dark,
                                fontWeight: FontWeight.w700,
                                fontSize: 30.0))
                      ],
                    ),
                    Material(
                        color: MyColors.aqua,
                        borderRadius: BorderRadius.circular(50.0),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(Icons.check_circle,
                              color: MyColors.light, size: 40.0),
                        )))
                  ]),
            ),
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 110.0),
          StaggeredTile.extent(2, 110.0),
          StaggeredTile.extent(2, 110.0),
          StaggeredTile.extent(2, 110.0),
          StaggeredTile.extent(2, 110.0),
        ],
      ),
    );
  }
}

Widget _buildTile(Widget widgetStuff, {Function() onTapAction}) {
  return Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(10.0),
      shadowColor: MyColors.light,
      child: InkWell(
          onTap: onTapAction != null
              ? () => onTapAction()
              : () {
                  print("Nothing set");
                },
          child: widgetStuff));
}
