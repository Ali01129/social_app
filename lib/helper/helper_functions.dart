import 'package:flutter/material.dart';

//displaying error
void displayMsgToUser(String text,BuildContext context){
  showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Text(text),
      )
  );
}