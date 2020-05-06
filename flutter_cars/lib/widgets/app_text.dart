import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  // const TextField({Key key}) : super(key: key);

  String label;
  String hint;
  bool password;
  TextInputType textInputType;
  FormFieldValidator<String> validator;
  FocusNode focusNode;
  FocusNode nextFocus;
  TextEditingController tController;

  AppText(
    this.label,
    this.hint,
    {this.password = false,
    this.textInputType,
    this.validator,
    this.focusNode, 
    this.nextFocus,
    this.tController}
    );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      validator: validator,
      keyboardType: textInputType,
      controller: tController,
      obscureText: password,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: TextStyle(
        color: Colors.blueGrey,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: label,
        hintText: hint,
      ),
    );
  }
}
