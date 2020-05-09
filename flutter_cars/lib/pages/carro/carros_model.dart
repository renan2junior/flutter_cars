import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/services/carro_api.dart';
import 'package:mobx/mobx.dart';

part 'carros_model.g.dart';

class CarrosModel = CarrosModelBase with _$CarrosModel;

abstract class CarrosModelBase with Store {
  @observable
  List<Carro> carros;

  @observable
  Exception error;

  @action
  loadCarros(tipo) async {
    try {
      this.error = null;
      this.carros = await CarroApi.getCarros(tipo);
    } catch (error) {
      this.error = error;
    }
  }
}
