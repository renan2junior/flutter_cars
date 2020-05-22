 import 'package:flutter/material.dart';

alert(BuildContext context, String title, String msg, {Function callback}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
                if(callback != null){
                   callback(); 
                }
              }, 
              
            )
          ],
        );
      },
    );
  }