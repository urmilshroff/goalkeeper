import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    elevation: 4,
    duration: Duration(seconds: 1),
  );
  Scaffold.of(context).showSnackBar(snackBar);
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}

String getFormattedDate(DateTime datetime) {
  return datetime.toString().substring(0, 16);
}
