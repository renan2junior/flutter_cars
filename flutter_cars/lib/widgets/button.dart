import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  
  Function onPressed;
  String text;

  Button(this.text, this.onPressed);

  // const Button({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
      ),
    );
  }
}