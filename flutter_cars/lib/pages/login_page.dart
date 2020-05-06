import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
    );
    return scaffold;
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: "Login",
              hintText: "Digite o login",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Senha",
              hintText: "Digite a senha",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            color: Colors.blue,
            onPressed: () {},
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          )
        ],
      ),
    );
  }
}
