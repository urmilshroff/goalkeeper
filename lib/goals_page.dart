import 'package:flutter/material.dart';
import 'package:goalkeeper/colors.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
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
        child: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                              style: TextStyle(
                                  color: MyColors.aqua, fontSize: 18)),
                          Text("Hello, World!",
                              style: TextStyle(
                                  color: invertColors(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28.0))
                        ],
                      ),
                      Material(
                          color: MyColors.aqua,
                          borderRadius: BorderRadius.circular(25.0),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(Icons.flag,
                                color: MyColors.light, size: 25.0),
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
                                  color: invertColors(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28.0))
                        ],
                      ),
                      Material(
                          color: MyColors.yellow,
                          borderRadius: BorderRadius.circular(25.0),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(Icons.flag,
                                color: MyColors.light, size: 25.0),
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
                                  color: MyColors.purple, fontSize: 18)),
                          Text("Hello, World!",
                              style: TextStyle(
                                  color: invertColors(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28.0))
                        ],
                      ),
                      Material(
                          color: MyColors.purple,
                          borderRadius: BorderRadius.circular(25.0),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(Icons.flag,
                                color: MyColors.light, size: 25.0),
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
                                  TextStyle(color: MyColors.red, fontSize: 18)),
                          Text("Hello, World!",
                              style: TextStyle(
                                  color: invertColors(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28.0))
                        ],
                      ),
                      Material(
                          color: MyColors.red,
                          borderRadius: BorderRadius.circular(25.0),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(Icons.flag,
                                color: MyColors.light, size: 25.0),
                          )))
                    ]),
              ),
            ),
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 100),
            StaggeredTile.extent(2, 100),
            StaggeredTile.extent(2, 100),
            StaggeredTile.extent(2, 100),
            StaggeredTile.extent(2, 100),
          ],
        ),
//          RaisedButton(
//            onPressed: changeBrightness,
//            color: MyColors.primaryColor,
//            splashColor: MyColors.accentColor,
//            child: Text("LIGHTS"),
//          ),
//        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: changeBrightness,
        icon: Icon(Icons.brightness_2),
        label: Text("LIGHTS"),
        foregroundColor: MyColors.light,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        elevation: 5.0,
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
        child: widgetStuff,
        splashColor: MyColors.light,
      ));
}
