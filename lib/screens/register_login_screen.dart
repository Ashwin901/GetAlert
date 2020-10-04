import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_alert_app/screens/main_screen.dart';
import 'package:get_alert_app/constants.dart';

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
  FirebaseAuth auth ;
  var title;
  @override
  void initState() {
    // TODO: implement initState
    emailController = TextEditingController();
    passwordController = TextEditingController();
    auth = FirebaseAuth.instance;
    title = widget.title;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffc93c),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('GetAlert',
            style: textStyle.copyWith(
              fontSize: 30
            )
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: EdgeInsets.all(6),
            child: TextField(
              style: textStyle,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value){
                setState(() {
                  email = value;
                });

              },
              controller: emailController,
              textAlign: TextAlign.center ,
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
                      borderSide: BorderSide(color: Colors.white
                      )
                  )
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: EdgeInsets.all(6),
            child: TextField(
              style: textStyle,
              onChanged: (value){
                password = value;
              },
              controller: passwordController,
              textAlign: TextAlign.center ,
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
                    borderSide: BorderSide(color: Colors.white)
                ),
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
              style: textStyle.copyWith(
                  color: Color(0xffffc93c)
              )
            ),
            onPressed: () async{
              var user;
              if(title == "register"){
                 user = await auth.createUserWithEmailAndPassword(email: email, password: password).catchError((e){
                   print(e.code);
                   handleErrors(e.code, context);
                 });
              }else{
                user = await auth.signInWithEmailAndPassword(email: email, password: password).catchError((e){
                  print(e.code);
                  handleErrors(e.code,context);
                });
              }
              emailController.clear();
              passwordController.clear();
              if(user != null){
                   Navigator.push(context, MaterialPageRoute(
                     builder: (context){
                       return MainScreen();
                     }
                   ));
              }

            },
            color: title == 'register' ? Colors.black : Colors.white,
          )
        ],
      ),
    );
  }
}

void handleErrors(String errorCode, BuildContext context){
  var errorMessage;
  switch(errorCode){
    case 'user-not-found': errorMessage = "Invalid username or password";
    break;
    case 'email-already-exists' : errorMessage = "User already exits";
    break;
    case 'invalid-email' : errorMessage ="Please enter a valid email address";
    break;
    case 'invalid-password' : errorMessage ="Invalid password";
    break;
    case 'weak-password' : errorMessage = 'Password should have more than six characters';
    break;
//    case 'wrong-password' : errorMessage = 'Invalid password';
//    break;
    default : errorMessage = '';
  }
  if(errorMessage.length >1){
    showDialog(context: (context),
    builder:(context){
      return AlertDialog(
        backgroundColor: Color(0xffffc93c),
        title: Text('Something went wrong',style: textStyle,),
        content: Text(errorMessage,style: textStyle,),
        actions: [
          RaisedButton(
            child: Text('ok',style: textStyle.copyWith(
              color: Color(0xffffc93c)
            ),),
            color: Colors.black,
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      );
    }
    );
  }
}