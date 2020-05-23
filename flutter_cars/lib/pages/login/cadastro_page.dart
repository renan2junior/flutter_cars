import 'package:flutter/material.dart';
import 'package:flutter_cars/firebase/firebase_service.dart';
import 'package:flutter_cars/pages/carro/home_page.dart';
import 'package:flutter_cars/services/api_response.dart';
import 'package:flutter_cars/utils/alert.dart';
import 'package:flutter_cars/utils/nav.dart';
import 'package:flutter_cars/widgets/app_text.dart';
import 'package:flutter_cars/widgets/button.dart';

class CadastroPage extends StatefulWidget {
  CadastroPage({Key key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController tName = TextEditingController(text: "Renan");
  final TextEditingController tEmail =
      TextEditingController(text: "renan@gmail.com");
  final TextEditingController tSenha = TextEditingController(text: "123456");

  bool _progress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: _body(),
    );
  }

  Container _body() {
    return Container(
      padding: EdgeInsets.all(16.00),
      child: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            AppText(
              "Nome",
              "Entre com o seu nome.",
              tController: tName,
              validator: validaNome,
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              "Email",
              "Entre com o email.",
              tController: tEmail,
              validator: _validatorEmail,
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              "Senha",
              "Entre com a sua senha.",
              tController: tSenha,
              validator: _validatorSenha,
            ),
            SizedBox(
              height: 20,
            ),
            Button("Cadastrar", _onClickCadastrar, _progress),
            Button("Cancelar", _onClickCancelar, false),
          ],
        ),
      ),
    );
  }

  _onClickCadastrar() async {
    String nome = tName.text;
    String senha = tSenha.text;
    String email = tEmail.text;

    if (!formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _progress = true;
    });

    print("Cadastro => $nome - $email - $senha");
    final FirebaseService service = FirebaseService();
    final ApiResponse response = await service.cadastrar(nome, email, senha);

    if (response.ok) {
      push(context, HomePage(), replace:true);
      alert(context, "Cadastro", "Cadastrado com sucesso");
    } else {
      alert(context, "Erro", response.msg);
    }

    setState(() {
      _progress = false;
    });
  }

  _onClickCancelar() {
    pop(context);
  }

  String _validatorSenha(String value) {
    if (value.isEmpty || value.length < 6) {
      return "Senha invalida";
    }
    return null;
  }

  String _validatorEmail(String value) {
    if (value.isEmpty || value.length < 5) {
      return "Email invalido";
    }
    return null;
  }

  String validaNome(String value) {
    if (value.isEmpty || value.length < 3) {
      return "Nome muito pequeno";
    }
    return null;
  }
}
