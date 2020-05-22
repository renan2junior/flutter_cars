import 'dart:async';

import 'package:flutter_cars/firebase/firebase_service.dart';
import 'package:flutter_cars/services/api_response.dart';

class LoginBloc {

  final StreamController _streamController = StreamController<bool>();

  get user => _streamController.stream;

  Future<ApiResponse> login(String login, String senha) async {
    _streamController.add(true);
    // ApiResponse response =  await LoginApi.login(login, senha);
    ApiResponse response = await FirebaseService().login(login, senha);
    _streamController.add(false);
    return response;
  }

  dispose() {
    _streamController.close();
  }
}
