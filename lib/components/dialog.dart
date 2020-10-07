import 'package:flutter/material.dart';
import 'package:get_alert_app/constants.dart';

//This dialog is used for all alert dialog operations mainly error handling
void dialog(var title,var message, BuildContext context){
  showDialog(
      context: (context),
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xffffc93c),
          title: Text(
            title,
            style: textStyle,
          ),
          content: Text(
            message,
            style: textStyle,
          ),
          actions: [
            RaisedButton(
              child: Text(
                'ok',
                style: textStyle.copyWith(color: Color(0xffffc93c)),
              ),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}
