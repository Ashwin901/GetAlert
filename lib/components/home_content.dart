import 'package:flutter/material.dart';
import 'package:get_alert_app/constants.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              style: textStyle,
              autofocus: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintStyle: textStyle,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Enter the message"),
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.all(15),
            hoverColor: Colors.white,
            child: Text(
              "send message",
              style: textStyle.copyWith(
                  color: Color(0xffffc93c)
              ),
            ),
            onPressed: () {},
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          )
        ],
      ),
    );
  }
}