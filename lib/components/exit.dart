import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_alert_app/constants.dart';

Future<bool> onBackPressed(BuildContext context) {
  return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color(0xffffc93c),
          title: Text(
            'Are you sure?',
            style: textStyle.copyWith(color: Colors.black),
          ),
          content: Text(
            'Do you want to exit the App',
            style: textStyle.copyWith(color: Colors.black),
          ),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              child: Text(
                "No",
                style: textStyle.copyWith(color: Color(0xffffc93c)),
              ),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              child: Text(
                "YES",
                style: textStyle.copyWith(
                  color: Color(0xffffc93c)
                ),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            )
          ],
        ),
      ) ??
      false;
}
