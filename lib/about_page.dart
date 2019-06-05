import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:goalkeeper/colors.dart';
import 'package:goalkeeper/my_goal.dart';
import 'package:goalkeeper/database_helper.dart';
import 'package:goalkeeper/public.dart';
import 'package:goalkeeper/about_page.dart';
import 'package:goalkeeper/no_goals.dart';
import 'package:goalkeeper/goals_page.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

Widget buildAboutPage(BuildContext context) {
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
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/urmil-vector.png")))),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text("Made by",
                        style: TextStyle(color: invertColors(context))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text("Urmil Shroff",
                        style: TextStyle(
                            color: invertColors(context),
                            fontWeight: FontWeight.w500,
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
                    child: Text("View on",
                        style: TextStyle(color: invertColors(context))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text("Twiter | GitHub | Website",
                        style: TextStyle(
                          color: invertColors(context),
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ]),
          ),
        ),
      ],
    ),
  );
}
