import 'dart:convert';

import 'package:flutter_cars/models/usuario.dart';
import 'package:flutter_cars/services/api_response.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    // var url = 'http://livrowebservices.com.br/rest/login';
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';
      Map params = {'username': login, 'password': senha};
      String _body = json.encode(params);
      Map<String, String> _headers = {"Content-Type": "application/json"};
      var response = await http.post(url, body: _body, headers: _headers);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

      Map _response = json.decode(response.body);
      if (response.statusCode == 200) {
        final user = Usuario.fromMap(_response);
        user.save();
        Usuario user2 = await Usuario.get();
        print("USUARIO OBJETO ==> $user2");

        return ApiResponse.ok(user);
      }
      // print("ERROR ===> $_response");
      return ApiResponse.error(_response["error"]);
    } catch (error, exception) {
      // print("Erro no login $error > $exception");
      return ApiResponse.error("Não foi possivel conectar com o servidor!!");
    }
  }
}
