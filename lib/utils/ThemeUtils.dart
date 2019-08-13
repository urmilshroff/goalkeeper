import 'package:flutter/material.dart';
import 'package:goalkeeper/Utils/colors.dart';

bool isThemeCurrentlyDark(BuildContext context) =>
    (Theme.of(context).brightness == Brightness.dark);

Color invertColors(BuildContext context) =>
    isThemeCurrentlyDark(context) ? MyColors.light : MyColors.dark;

Brightness getInvertTheme(BuildContext context) =>
    isThemeCurrentlyDark(context) ? Brightness.light : Brightness.dark;
