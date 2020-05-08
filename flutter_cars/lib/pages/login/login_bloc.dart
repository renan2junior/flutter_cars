import 'dart:async';

import 'package:flutter_cars/models/usuario.dart';
import 'package:flutter_cars/services/api_response.dart';
import 'package:flutter_cars/services/login_api.dart';

class LoginBloc {

  final StreamController _streamController = StreamController<bool>();

  get user => _streamController.stream;

  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    _streamController.add(true);
    ApiResponse response =  await LoginApi.login(login, senha);
    _streamController.add(false);
    return response;
  }

  dispose() {
    _streamController.close();
  }
}
