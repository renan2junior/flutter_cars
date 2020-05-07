import 'dart:convert';

import 'package:flutter_cars/models/usuario.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<Usuario> login(String login, String senha) async {
    // var url = 'http://livrowebservices.com.br/rest/login';
    var url = 'https://carros-springboot.herokuapp.com/api/v2/login';
    Map params = {'username': login, 'password': senha};
    String _body = json.encode(params);
    Map<String,String> _headers = { 
      "Content-Type":"application/json"
    };
    var response = await http.post(url, body: _body, headers: _headers);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map _response = json.decode(response.body);

    final user = Usuario.fromMap(_response);

    return user;
  }
}
