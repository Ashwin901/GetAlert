import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_alert_app/components/dialog.dart';
import 'package:get_alert_app/constants.dart';
import 'package:sms/sms.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  var messageValue;
  var id;
  TextEditingController messageController;
  var contacts;

  void sendMessage(var message, var contacts) async {
    SmsSender sender = new SmsSender();
    for (int i = 0; i < contacts.length; i++) {
      var address = contacts[i].data()['number'];
      SmsMessage message = new SmsMessage(address, messageValue);
      message.onStateChanged.listen((state) {
        if (state == SmsMessageState.Sent) {
          print("SMS is sent!");
        } else if (state == SmsMessageState.Delivered) {
          print("SMS is delivered!");
        }
      });
      sender.sendSms(message);
    }
    messageController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    id = FirebaseAuth.instance.currentUser.uid;
    messageController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("contacts")
          .doc(id)
          .collection('userContacts')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.black,
          ));
        }

        contacts = snapshot.data.docs;

    return contacts.length == 0
        ? Center(
      child: Text(
        "Please add contacts to send a message",
        style: textStyle,
      ),
    )
        : Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                messageValue = value;
              },
              controller: messageController,
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
              style: textStyle.copyWith(color: Color(0xffffc93c)),
            ),
            onPressed: () {
              sendMessage(messageValue, contacts);
              dialog('Success', 'Message delivered to your contacts', context);//From dialog.dart
            },
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          )
        ],
      ),
    );
  }
  );
  }
}
