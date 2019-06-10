import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:goalkeeper/utils/public.dart';

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
            child: Text("No goals yet",
                style: TextStyle(
                  color: invertColors(context),
                  fontSize: 18.0,
                )),
          ),
        ],
      ),
    ),
  );
}
