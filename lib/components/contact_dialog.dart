import 'package:flutter/material.dart';
import 'package:get_alert_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void displayDialog(BuildContext context, String id) {
  var name='';
  var number='';
  showDialog(
      context: (context),
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xffffc93c),
          title: Text("Add contact",
            style: textStyle,
          ),
          content: Container(
            height: 300,
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        onChanged: (value){
                          name = value;
                        },
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
                            hintText: "Enter the name"
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      TextField(
                        onChanged: (value){
                          number = value;
                        },
                        keyboardType: TextInputType.number,
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
                            hintText: "Enter the number"),
                      )],
                  ),
                ),
              ),
            ),
          ),
          actions: [
            RaisedButton(
              padding: EdgeInsets.all(15),
              hoverColor: Colors.white,
              child: Text(
                "add",
                style: textStyle.copyWith(
                    color: Color(0xffffc93c)
                ),
              ),
              onPressed: () {
                //Here we ensure that the user enters a name and number before pressing the button.
                if(name.length >0 && number.length >0){
                  //We add data specific to each user so we specify an id for each user while storing data in fireStore.
                  FirebaseFirestore.instance.collection('contacts').doc(id).collection('userContacts').add({
                    'name' : name,
                    'number' : number
                  });
                }
                Navigator.pop(context);
                },
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
            )
          ],
        );
      });
}