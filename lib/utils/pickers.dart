import 'package:flutter/material.dart';

Future<DateTime> pickDate(BuildContext context) async {
  var startDate = DateTime.now();
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: startDate,
    firstDate: startDate,
    lastDate: startDate.add(
      Duration(days: 365),
    ),
  );
  return picked;
}

Future<TimeOfDay> pickTime(BuildContext context, {DateTime initialTime}) async {
  final TimeOfDay picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  return picked;
}
