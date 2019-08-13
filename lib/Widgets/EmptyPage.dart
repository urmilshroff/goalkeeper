import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:goalkeeper/Utils/ThemeUtils.dart';

class EmptyPage extends StatelessWidget {
  EmptyPage({color});

  @override
  Widget build(BuildContext context) {
    Color invertColor = invertColors(context);
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              EvaIcons.flag,
              size: 64.0,
              color: invertColor,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "No goals yet",
                style: TextStyle(
                  color: invertColor,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
