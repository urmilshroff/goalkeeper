import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goalkeeper/Utils/HelperUtils.dart';
import 'package:goalkeeper/Widgets/BuildTile.dart';
import 'package:goalkeeper/Utils/ThemeUtils.dart';

Widget buildAboutPage(BuildContext context) {
  double _width = MediaQuery.of(context).size.width * 0.75;
  Color invertColor = invertColors(context);

  return Container(
    child: ListView(
      padding: EdgeInsets.only(top: 8.0, left: 6.0, right: 6.0),
      children: <Widget>[
        BuildTile(
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 75.0,
                  height: 75.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/urmil-vector.png"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "</> by",
                    style: TextStyle(
                        color: invertColor, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    "Urmil Shroff",
                    style: TextStyle(
                        color: invertColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        BuildTile(
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "Connect",
                    style: TextStyle(
                        color: invertColor, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: IconButton(
                          icon: Icon(EvaIcons.person),
                          color: invertColor,
                          onPressed: () =>
                              launchURL('https://urmilshroff.tech/'),
                        ),
                      ),
                      GestureDetector(
                        child: IconButton(
                          icon: Icon(EvaIcons.twitter),
                          color: invertColor,
                          onPressed: () =>
                              launchURL('https://twitter.com/urmilshroff'),
                        ),
                      ),
                      GestureDetector(
                        child: IconButton(
                          icon: Icon(EvaIcons.github),
                          color: invertColor,
                          onPressed: () =>
                              launchURL('https://github.com/urmilshroff'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        BuildTile(
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "Support",
                    style: TextStyle(
                        color: invertColor, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: _width,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Like the app? Show your support by writing"
                              " a review on the Play Store, starring it on"
                              " GitHub and sharing it with your "
                              "friends!",
                              style:
                                  TextStyle(color: invertColor, fontSize: 16.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: IconButton(
                                    icon: Icon(EvaIcons.edit),
                                    color: invertColor,
                                    onPressed: () => launchURL(
                                        'https://play.google.com/store/apps/details?id=tech.urmilshroff.goalkeeper'),
                                  ),
                                ),
                                GestureDetector(
                                  child: IconButton(
                                    icon: Icon(EvaIcons.star),
                                    color: invertColor,
                                    onPressed: () => launchURL(
                                        'https://github.com/urmilshroff/goalkeeper'),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        BuildTile(
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "Feedback",
                    style: TextStyle(
                        color: invertColor, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: _width,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Bugs found? Feature suggestions? Create a "
                              "new issue on GitHub to let me know, or"
                              " contribute by forking and sending a "
                              "PR!",
                              style:
                                  TextStyle(color: invertColor, fontSize: 16.0),
                            ),
                            GestureDetector(
                              child: IconButton(
                                icon: Icon(EvaIcons.github),
                                color: invertColor,
                                onPressed: () => launchURL(
                                    'https://github.com/urmilshroff/goalkeeper'),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    ),
  );
}
