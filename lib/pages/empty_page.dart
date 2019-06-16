import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:goalkeeper/utils/public.dart';

class FlagFade extends StatefulWidget {
  @override
  createState() => FlagFadeState();
}

class FlagFadeState extends State<FlagFade> {
  double opacityLevel = 1.0;
  int animationDuration = 5;

  void _changeOpacity() {
    for (int i = 0; i < 5; i++) {
      setState(() {
        opacityLevel = opacityLevel == 0 ? 1.0 : 0.0;
        opacityLevel = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _changeOpacity();
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              opacity: opacityLevel,
              duration: Duration(seconds: animationDuration),
              child: Icon(
                EvaIcons.flag,
                size: 64.0,
                color: invertColors(context),
              ),
            ),
            AnimatedOpacity(
              opacity: opacityLevel,
              duration: Duration(seconds: animationDuration),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("No goals yet",
                    style: TextStyle(
                      color: invertColors(context),
                      fontSize: 18.0,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
