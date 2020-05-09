import 'package:flutter/material.dart';

class TestError extends StatelessWidget {
  // const TestError({Key key}) : super(key: key);
  String msg;
  Function onPressed;

  TestError(this.msg, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Center(
          child: Text(
            msg,
            style: TextStyle(
              color: Colors.red,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
