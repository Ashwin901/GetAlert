import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_alert_app/constants.dart';

Future<bool> onBackPressed(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Are you sure?',
        style: textStyle.copyWith(color: Colors.black),
      ),
      content: Text(
        'Do you want to exit the App',
        style: textStyle.copyWith(color: Colors.black),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "No",
            style: textStyle,
          ),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        FlatButton(
          child: Text(
            "YES",
            style: textStyle,
          ),
          color: Colors.black,
          onPressed: () {
            SystemNavigator.pop();
          },
        )

      ],
    ),
  ) ??
      false;
}