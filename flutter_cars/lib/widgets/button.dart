import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Function onPressed;
  String text;
  bool showProgress;

  Button(this.text, this.onPressed, this.showProgress);

  // const Button({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      onPressed: onPressed,
      child: showProgress
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
    );
  }
}
