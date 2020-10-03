import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_alert_app/constants.dart';

class ContactsContent extends StatefulWidget {
  @override
  _ContactsContentState createState() => _ContactsContentState();
}

class _ContactsContentState extends State<ContactsContent> {
  var userID;
  var currentUser;
  FirebaseAuth auth;
  var id;
  @override
  void initState() {
    // TODO: implement initState
    auth = FirebaseAuth.instance;
    getId();
    super.initState();
  }

  void getId(){
    currentUser = auth.currentUser;
    id = currentUser.uid;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('contacts')
          .doc(id)
          .collection('userContacts')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        print(id);
        if (snapshot.data == null) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.black,
          ));
        }
        var contacts = snapshot.data.docs;
        return contacts.length == 0
            ? Center(
                child: Text(
                  'No emergency contacts added',
                  style: textStyle,
                ),
              )
            : ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 7,
                    color: Color(0xffffc93c),
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.only(left: 14),
                      title: Text(
                        contacts[index].data()['name'],
                        style: textStyle.copyWith(
                          fontSize: 23
                        ),
                      ),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "number :"+contacts[index].data()['number'],
                              style: textStyle.copyWith(
                                fontSize: 18
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  );
                });
      },
    );
  }
}
