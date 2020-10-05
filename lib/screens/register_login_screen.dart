import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_alert_app/screens/main_screen.dart';
import 'package:get_alert_app/constants.dart';
import 'package:get_alert_app/components/handle_errors.dart';

class RegisterOrLoginScreen extends StatefulWidget {
  final title;
  RegisterOrLoginScreen({this.title});
  @override
  _RegisterOrLoginScreenState createState() => _RegisterOrLoginScreenState();
}

class _RegisterOrLoginScreenState extends State<RegisterOrLoginScreen> {
  TextEditingController emailController;
  TextEditingController passwordController;
  String email;
  String password;
  FirebaseAuth auth;
  var title;
  bool check;
  @override
  void initState() {
    // TODO: implement initState
    emailController = TextEditingController();
    passwordController = TextEditingController();
    auth = FirebaseAuth.instance;
    title = widget.title;
    check = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffc93c),
      body: check == true? Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),) : Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('GetAlert', style: textStyle.copyWith(fontSize: 30)),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: EdgeInsets.all(6),
                child: TextField(
                  style: textStyle,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  controller: emailController,
                  textAlign: TextAlign.center,
                  showCursor: true,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "enter email",
                      hintStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white))),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: EdgeInsets.all(6),
                child: TextField(
                  style: textStyle,
                  onChanged: (value) {
                    password = value;
                  },
                  controller: passwordController,
                  textAlign: TextAlign.center,
                  showCursor: true,
                  cursorColor: Colors.black,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintStyle: textStyle,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "enter password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                child: Text(title,
                    style: textStyle.copyWith(color: Color(0xffffc93c))),
                onPressed: () async {
                  setState(() {
                    check = true;
                  });
                  var user;
                  if (title == "register") {
                    user = await auth
                        .createUserWithEmailAndPassword(
                            email: email, password: password)
                        .catchError((e) {
                          print(e.code);
                          setState(() {
                            check = false;
                          });
                      handleErrors(e.code, context);
                    });

                  } else {
                    user = await auth
                        .signInWithEmailAndPassword(
                            email: email, password: password)
                        .catchError((e) {
                     setState(() {
                       check = false;
                     });
                      handleErrors(e.code, context);
                    });
                  }
                  emailController.clear();
                  passwordController.clear();
                  if (user != null) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return MainScreen();
                    }));
                    setState(() {
                      check = false;
                    });
                  }
                },
                color: title == 'register' ? Colors.black : Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}


