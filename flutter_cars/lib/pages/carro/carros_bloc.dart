import 'dart:async';

import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/services/carro_api.dart';

class CarrosBloc {

  final _streamController = StreamController<List<Carro>>();

  get stream => _streamController.stream;

  loadCarros(tipo) async {
    List<Carro> carros = await CarroApi.getCarros(tipo);
    _streamController.add(carros);
  }

  void dispose() {
    _streamController.close();
  }
}
