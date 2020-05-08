import 'package:flutter/material.dart';

class TestError extends StatelessWidget {
  // const TestError({Key key}) : super(key: key);
  String msg;

  TestError(this.msg);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          msg,
          style: TextStyle(
            color: Colors.red,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
