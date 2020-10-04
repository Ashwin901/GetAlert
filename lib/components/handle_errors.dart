import 'package:flutter/material.dart';
import 'package:get_alert_app/components/dialog.dart';

void handleErrors(String errorCode, BuildContext context) {
  var errorMessage;
  switch (errorCode) {
    case 'user-not-found':
      errorMessage = "Invalid username or password";
      break;
    case 'email-already-exists':
      errorMessage = "User already exits";
      break;
    case 'invalid-email':
      errorMessage = "Please enter a valid email address";
      break;
    case 'invalid-password':
      errorMessage = "Invalid password";
      break;
    case 'weak-password':
      errorMessage = 'Password should have more than six characters';
      break;
    case 'wrong-password':
      errorMessage = 'Invalid password';
      break;
    default:
      errorMessage = '';
  }
  if (errorMessage.length > 1) {
    dialog('Something went wrong',errorMessage,context);//From dialog.dart class
  }
}