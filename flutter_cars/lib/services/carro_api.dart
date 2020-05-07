import 'dart:convert';

import 'package:flutter_cars/models/carro.dart';
import 'package:http/http.dart' as http;

class CarroApi {
  static Future<List<Carro>> getCarros() async {
      String url = "http://carros-springboot.herokuapp.com/api/v1/carros";
      var response = await http.get(url); 
      String _json = response.body;
      List list = json.decode(_json);
      // final carros = List<Carro>();

      // for(Map map in list){
      //   Carro carro = Carro.fromMap(map);
      //   carros.add(carro);
      // }

      final List<Carro> carros = list.map<Carro>((map)=>Carro.fromMap(map)).toList();

      return carros;
   }
}
