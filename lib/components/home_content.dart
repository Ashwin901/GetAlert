import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  String defaultMessage;
  Future sendMessage(var message, var contacts) async {
    //This function is used to send message to all the contacts added.
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
      await sender.sendSms(message);
    }
    setState(() {
      messageValue = defaultMessage;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    id = FirebaseAuth.instance.currentUser.uid;
    defaultMessage = 'Help me';
    messageController = TextEditingController(text: defaultMessage);
    messageValue = defaultMessage;
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
                child: SpinKitWave(
                  color: Colors.black,
                )
            );
          }

          contacts = snapshot.data.docs;

          return Container(
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
                  onPressed: () async {
                    //If no contacts is added then the user is asked to contacts in the contacts section.
                    if (contacts.length == 0) {
                      dialog("Info", "Add contacts to send messages", context);
                    } else {
                      if (messageValue.length > 0) {
                        await sendMessage(messageValue, contacts);//Message is sent to this function which sends the message to the added contacts
                        dialog('Success', 'Message delivered to your contacts',
                            context); //From dialog.dart
                      }
                    }
                  },
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
              ],
            ),
          );
        });
  }
}
