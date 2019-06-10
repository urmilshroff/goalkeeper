import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:goalkeeper/utils/public.dart';

Widget buildAboutPage(BuildContext context) {
  double _width = MediaQuery.of(context).size.width * 0.75;

  return Container(
    child: ListView(
      children: <Widget>[
        buildTile(
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
                              image: AssetImage("assets/urmil-vector.png")))),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text("</> by",
                        style: TextStyle(
                            color: invertColors(context),
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text("Urmil Shroff",
                        style: TextStyle(
                            color: invertColors(context),
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0)),
                  ),
                ]),
          ),
        ),
        buildTile(
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text("Connect",
                        style: TextStyle(
                            color: invertColors(context),
                            fontWeight: FontWeight.w500)),
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
                              icon: Icon(EvaIcons.google),
                              color: invertColors(context),
                              onPressed: () => doNothing()),
                        ),
                        GestureDetector(
                          child: IconButton(
                              icon: Icon(EvaIcons.email),
                              color: invertColors(context),
                              onPressed: () => doNothing()),
                        ),
                        GestureDetector(
                          child: IconButton(
                              icon: Icon(EvaIcons.twitter),
                              color: invertColors(context),
                              onPressed: () => doNothing()),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
        buildTile(
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text("Feedback",
                        style: TextStyle(
                            color: invertColors(context),
                            fontWeight: FontWeight.w500)),
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
                                  style: TextStyle(
                                      color: invertColors(context),
                                      fontSize: 16.0)),
                              GestureDetector(
                                child: IconButton(
                                    icon: Icon(EvaIcons.github),
                                    color: invertColors(context),
                                    onPressed: () => doNothing()),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ),
//        buildTile(
//          Padding(
//            padding: const EdgeInsets.all(10.0),
//            child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Center(
//                    child: Text("Open Source usages",
//                        style: TextStyle(
//                            color: invertColors(context),
//                            fontWeight: FontWeight.w500)),
//                  ),
//                  SizedBox(
//                    height: 5,
//                  ),
//                  Center(
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: <Widget>[
//                            Text("Flutter",
//                                style: TextStyle(
//                                    color: invertColors(context),
//                                    fontWeight: FontWeight.w500,
//                                    fontSize: 16.0)),
//                            GestureDetector(
//                              child: IconButton(
//                                  icon: Icon(EvaIcons.github),
//                                  color: invertColors(context),
//                                  onPressed: () => doNothing()),
//                            ),
//                          ],
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: <Widget>[
//                            Text("Dashboard UI",
//                                style: TextStyle(
//                                    color: invertColors(context),
//                                    fontWeight: FontWeight.w500,
//                                    fontSize: 16.0)),
//                            GestureDetector(
//                              child: IconButton(
//                                  icon: Icon(EvaIcons.github),
//                                  color: invertColors(context),
//                                  onPressed: () => doNothing()),
//                            ),
//                          ],
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: <Widget>[
//                            Text("Dynamic Theme",
//                                style: TextStyle(
//                                    color: invertColors(context),
//                                    fontWeight: FontWeight.w500,
//                                    fontSize: 16.0)),
//                            GestureDetector(
//                              child: IconButton(
//                                  icon: Icon(EvaIcons.github),
//                                  color: invertColors(context),
//                                  onPressed: () => doNothing()),
//                            ),
//                          ],
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: <Widget>[
//                            Text("Eva Icons",
//                                style: TextStyle(
//                                    color: invertColors(context),
//                                    fontWeight: FontWeight.w500,
//                                    fontSize: 16.0)),
//                            GestureDetector(
//                              child: IconButton(
//                                  icon: Icon(EvaIcons.github),
//                                  color: invertColors(context),
//                                  onPressed: () => doNothing()),
//                            ),
//                          ],
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: <Widget>[
//                            Text("Speed Dial",
//                                style: TextStyle(
//                                    color: invertColors(context),
//                                    fontWeight: FontWeight.w500,
//                                    fontSize: 16.0)),
//                            GestureDetector(
//                              child: IconButton(
//                                  icon: Icon(EvaIcons.github),
//                                  color: invertColors(context),
//                                  onPressed: () => doNothing()),
//                            ),
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
//                ]),
//          ),
//        ),
      ],
    ),
  );
}