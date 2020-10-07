import 'package:get_alert_app/screens/register_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_alert_app/constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffc93c),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Image(image: AssetImage('images/getAlert_logo.png'),height: 120,),
                  Text("GetAlert",style: textStyle.copyWith(
                    fontSize: 30
                  ),),
                SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    RaisedButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.black87,
                      child: Text('register',
                        style: textStyle.copyWith(
                            color: Color(0xffffc93c)
                        )
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return RegisterOrLoginScreen(title: "register",);
                            }
                        ));
                      },
                    ),
                    SizedBox(
                      width: 8,
                    ),

                    RaisedButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.white,
                      child: Text('login',
                        style: textStyle.copyWith(
                            color: Color(0xffffc93c)
                        )
                      ),
                      onPressed: (){
                        //Here we send the title to decide if the user wants to register or login
                         Navigator.push(context , MaterialPageRoute(builder: (context){
                           return RegisterOrLoginScreen(title: 'login',);
                         }));
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

