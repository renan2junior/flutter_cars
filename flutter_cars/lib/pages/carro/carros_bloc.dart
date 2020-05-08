import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/services/carro_api.dart';
import 'package:flutter_cars/utils/simple_bloc.dart';

class CarrosBloc extends SimpleBloc<List<Carro>> {
  loadCarros(tipo) async {
    try {
      List<Carro> carros = await CarroApi.getCarros(tipo);
      add(carros);
    } catch (error) {
      addError(error);
    }
  }
}
