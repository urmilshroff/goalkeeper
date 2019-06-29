import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:goalkeeper/utils/colors.dart';
import 'package:goalkeeper/utils/functions.dart';

//publicly usable widgets

Widget buildTile(Widget widgetContent, {Function() onTap}) {
  return Container(
    margin: const EdgeInsets.all(5.0),
    child: Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: onTap != null
            ? () => onTap()
            : () {
                print("Nothing set");
              },
        child: widgetContent,
        splashColor: MyColors.accentColor,
      ),
    ),
  );
} //build material goal card

Widget buildEmptyPage(BuildContext context) {
  return Container(
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            EvaIcons.flag,
            size: 64.0,
            color: invertColors(context),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "No goals yet",
              style: TextStyle(
                color: invertColors(context),
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );
} //build empty page
