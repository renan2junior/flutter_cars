import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/pages/carro/carro_dao.dart';
import 'package:flutter_cars/services/carro_api.dart';
import 'package:flutter_cars/utils/network.dart';
import 'package:flutter_cars/utils/simple_bloc.dart';

class CarrosBloc extends SimpleBloc<List<Carro>> {
  Future<List<Carro>> loadCarros(tipo) async {
    try {
      bool netWorkOn = await isNetworkOn();
      if (!netWorkOn) {
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
        return carros;
      }
      List<Carro> carros = await CarroApi.getCarros(tipo);

      final dao = CarroDAO();
      if (carros.isNotEmpty) {
        carros.forEach(dao.save);
      }
      add(carros);
      return carros;
    } catch (error) {
      addError(error);
    }
  }
}
