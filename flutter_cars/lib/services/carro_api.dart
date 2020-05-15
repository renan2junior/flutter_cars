import 'dart:convert';

import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/models/usuario.dart';
import 'package:flutter_cars/pages/favoritos/carro_dao.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarroApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario user = await Usuario.get();
    String url =
        "http://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo";
    Map<String, String> _header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };
    print(url);
    var response = await http.get(url, headers: _header);
    String _json = response.body;
    try {
      List list = json.decode(_json);
      final List<Carro> carros =
          list.map<Carro>((map) => Carro.fromMap(map)).toList();

      final dao = CarroDAO();
      carros.forEach(dao.save);     
      
      return carros;
    } catch (error, exception) {
      print("Error : ${error} Exception : ${exception}");
      throw error;
    }
  }
}
 