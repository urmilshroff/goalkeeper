import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:goalkeeper/Utils/colors.dart';

class BuildTile extends StatelessWidget {
  BuildTile(this.widgetContent, {this.onTap});
  final Function onTap;
  final Widget widgetContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: onTap ?? this.defaultOnTap,
          child: widgetContent,
          splashColor: MyColors.accentColor,
        ),
      ),
    );
  }

  void defaultOnTap() {}
}
