
import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/utils/sql/dao.dart';

class CarroDAO extends DAO<Carro>{
  @override
  String get tableName => "carro";

  Future<List<Carro>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from carro where tipo =? ',[tipo]);

    return list.map<Carro>((json) => Carro.fromMap(json)).toList();
  }

  @override
  Carro fromMap(Map<String, dynamic > map) {
    return Carro.fromMap(map);
  }

}