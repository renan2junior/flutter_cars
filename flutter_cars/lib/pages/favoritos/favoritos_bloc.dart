import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/pages/favoritos/favoritos_service.dart';
import 'package:flutter_cars/utils/simple_bloc.dart';

class FavoritosBloc extends SimpleBloc<List<Carro>> {
  Future<List<Carro>> fetch() async {
    try {
      List<Carro> carros = await FavoritosService.getCarros();
      print(carros);
      add(carros);
      return carros;
    } catch (error) {
      addError(error);
    }
  }
}
