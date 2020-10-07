import 'package:flutter/material.dart';
import 'package:get_alert_app/components/exit.dart';
import 'package:get_alert_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_alert_app/components/home_content.dart';
import 'package:get_alert_app/components/contact_dialog.dart';
import 'package:get_alert_app/components/contacts_content.dart';
import 'package:get_alert_app/screens/welcome_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index;
  var id;
  @override
  void initState() {
    // TODO: implement initState
    index = 0;
    id = FirebaseAuth.instance.currentUser.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      //WillPopScope is used to handle the back button
      onWillPop: (){
       return onBackPressed(context); //This function is present in exit.dart
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xffffc93c),
          appBar: AppBar(
            backgroundColor: Color(0xffffc93c),
            leading:  popUpButton(context),
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
                });//index =0 is for home content(home_content.dart)
              } else {
                setState(() {
                  index = 1;
                });//index =1 is for contact content(contact_content.dart)
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
                    "contacts",
                    style: textStyle,
                  ),
                  icon: Icon(Icons.contacts),
                  activeIcon: (Icon(
                    Icons.contacts,
                    color: Colors.white,
                  )))
            ],
          ),
          body:index == 0 ? HomeContent() : ContactsContent(),
          floatingActionButton: index == 0
              ? Container()
              : FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.add,
                    color: Color(0xffffc93c),
                  ),
                  onPressed: () {
                    //This dialog is used to accept contacts when the user is in contact_content(or index=1)
                    displayDialog(context,id);//This function is in contact_dialog.dart
                  },
                ),
        ),
      ),
    );
  }
}

//This button is in the appbar to handle logout activity
Widget popUpButton(BuildContext context){
  return PopupMenuButton(
      onSelected: (value) async{
        await FirebaseAuth.instance.signOut();
        Navigator.push(context,MaterialPageRoute(
            builder: (context){
              return WelcomeScreen();
            }
        ));
      },
      icon: Icon(Icons.menu,
        color: Colors.black,),
      color: Color(0xffffc93c),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          value: 'logout',
          child: Text('logout',
            style: textStyle,
          ),
        )
      ]
  );
}



