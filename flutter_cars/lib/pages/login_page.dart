import 'package:flutter/material.dart';
import 'package:flutter_cars/models/usuario.dart';
import 'package:flutter_cars/pages/home_page.dart';
import 'package:flutter_cars/services/login_api.dart';
import 'package:flutter_cars/utils/nav.dart';
import 'package:flutter_cars/widgets/app_text.dart';
import 'package:flutter_cars/widgets/button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController tLogin = TextEditingController(text: "admin");
  final TextEditingController tSenha = TextEditingController(text: "123");
  final FocusNode _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
  }

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
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            AppText("Login", "Entre com o seu login.",
                validator: _validatorLogin,
                tController: tLogin,
                textInputType: TextInputType.emailAddress,
                nextFocus: _focusSenha),
            SizedBox(
              height: 10,
            ),
            AppText("Senha", "Entre com a sua senha",
                validator: _validatorSenha,
                password: true,
                tController: tSenha,
                textInputType: TextInputType.number,
                focusNode: _focusSenha),
            SizedBox(
              height: 20,
            ),
            Button("Login", _onClickLogin)
          ],
        ),
      ),
    );
  }

  String _validatorLogin(String text) {
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String _validatorSenha(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    return null;
  }

  _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    Usuario user  = await LoginApi.login(tLogin.text, tSenha.text);
    
    if (user!=null) {
      print(user);
      push(context, HomePage());
    }else{
      print("Deu ruim!!");
    }
    
    return;
  }
}
