import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
class Utils{

  static toastMessage(String message){
    Fluttertoast.showToast(msg: message,backgroundColor: Colors.green,textColor: Colors.red);
  }

  static void flushBarErrorMessages(String errorMessage , BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(
      message: errorMessage,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
      messageColor: Colors.white,
    )..show(context));
  }

  static snackBar(String message ,BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode nextFocus){

    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}