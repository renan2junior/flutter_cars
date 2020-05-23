import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_cars/firebase/firebase_service.dart';
import 'package:flutter_cars/models/usuario.dart';
import 'package:flutter_cars/pages/carro/home_page.dart';
import 'package:flutter_cars/pages/login/cadastro_page.dart';
import 'package:flutter_cars/pages/login/login_bloc.dart';
import 'package:flutter_cars/services/api_response.dart';
import 'package:flutter_cars/utils/alert.dart';
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
  final TextEditingController _tLogin = TextEditingController();
  final TextEditingController _tSenha = TextEditingController();
  final FocusNode _focusSenha = FocusNode();

  final LoginBloc _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    _loadUsuario();
  }

  _loadUsuario() async {
    Usuario user = await Usuario.get();
    if (user != null) {
      push(context, HomePage());
    }
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
                tController: _tLogin,
                textInputType: TextInputType.emailAddress,
                nextFocus: _focusSenha),
            SizedBox(
              height: 10,
            ),
            AppText("Senha", "Entre com a sua senha",
                validator: _validatorSenha,
                password: true,
                tController: _tSenha,
                textInputType: TextInputType.number,
                focusNode: _focusSenha),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<bool>(
                stream: _bloc.user,
                initialData: false,
                builder: (context, snapshot) {
                  return Button("Login", _onClickLogin, snapshot.data);
                }),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: GoogleSignInButton(
                onPressed: _onClickGoogle,
              ),
            ),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: Button("Cadastro", _onClickCadastro, false),
            )
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

  void _onClickGoogle() async {
    final service = FirebaseService();
    ApiResponse response = await service.loginGoogle();
    if (response.ok) {
      push(context, HomePage(), replace: true);
    } else {
      alert(context, "Erro", response.msg);
    }
  }

  _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    ApiResponse response = await _bloc.login(_tLogin.text, _tSenha.text);
    if (response.ok) {
      push(context, HomePage(), replace: true);
    } else {
      alert(context, "Erro", response.msg);
    }
    return;
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  _onClickCadastro() {
    push(context, CadastroPage());
  }
}
