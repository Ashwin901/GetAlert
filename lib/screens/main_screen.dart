import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_alert_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_alert_app/components/home_content.dart';
import 'package:get_alert_app/components/contact_dialog.dart';
import 'package:get_alert_app/components/contacts_content.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirebaseAuth auth;
  int index;
  var user;
  var id;
  @override
  void initState() {
    // TODO: implement initState
    index = 0;
    auth = FirebaseAuth.instance;
    getId();
    super.initState();
  }

  void getId(){
     user = auth.currentUser;
     id = user.uid;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffffc93c),
      appBar: AppBar(
        backgroundColor: Color(0xffffc93c),
        leading: Container(),
        centerTitle: true,
        title: Text(
          'GetAlert',
          style: textStyle,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (item) {
          if (item == 0) {
            setState(() {
              index = 0;
            });
          } else {
            setState(() {
              index = 1;
            });
          }
        },
        currentIndex: index,
        backgroundColor: Color(0xffffc93c),
        items: [
          BottomNavigationBarItem(
              title: Text(
                "home",
                style: textStyle,
              ),
              icon: Icon(Icons.home),
              activeIcon: (Icon(
                Icons.home,
                color: Colors.white,
              ))),
          BottomNavigationBarItem(
              title: Text(
                "contacts.",
                style: textStyle,
              ),
              icon: Icon(Icons.contacts),
              activeIcon: (Icon(
                Icons.contacts,
                color: Colors.white,
              )))
        ],
      ),
      body: index == 0 ? HomeContent() : ContactsContent(),
      floatingActionButton: index == 0
          ? Container()
          : FloatingActionButton(
              backgroundColor: Colors.black,
              child: Icon(
                Icons.add,
                color: Color(0xffffc93c),
              ),
              onPressed: () {
                displayDialog(context,id);
              },
            ),
    );
  }
}






