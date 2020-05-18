import 'dart:convert';

import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/services/api_response.dart';
import 'package:flutter_cars/utils/http_helper.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarroApi {

  static Future<ApiResponse<bool>> delete(Carro carro) async {
    var url = "http://carros-springboot.herokuapp.com/api/v2/carros/${carro.id}";
    var response = await http.delete(url);
    if(response.statusCode == 200 ){
      return ApiResponse.ok(true);
    }
    Map mapResponse  = json.decode(response.body);
    return ApiResponse.error(mapResponse["error"]);
  }

  static Future<ApiResponse<bool>> save(Carro carro) async {
    String stringJson = carro.toJson();
    var url = "http://carros-springboot.herokuapp.com/api/v2/carros";
    if (carro.id != null) {
      url = url + "/${carro.id}";
    }
    var response = await (carro.id == null
        ? http.post(url, body: stringJson)
        : http.put(url, body: stringJson));
    if (response.statusCode == 201 || response.statusCode == 200) {
      Map mapResponse = json.decode(response.body);
      Carro carro = Carro.fromMap(mapResponse);
      print("Carro ===> ${carro.id}");
      return ApiResponse.ok(true);
    }
    Map mapResponse = json.decode(response.body);
    return ApiResponse.error(mapResponse["error"]);
  }

  static Future<List<Carro>> getCarros(String tipo) async {
    String url =
        "http://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo";
    print(url);
    var response = await http.get(url);
    String _json = response.body;
    try {
      List list = json.decode(_json);
      final List<Carro> carros =
          list.map<Carro>((map) => Carro.fromMap(map)).toList();
      return carros;
    } catch (error, exception) {
      print("Error : ${error} Exception : ${exception}");
      throw error;
    }
  }
}
