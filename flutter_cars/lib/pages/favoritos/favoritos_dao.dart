import 'package:flutter_cars/utils/sql/dao.dart';
import 'package:flutter_cars/models/favorito.dart';

class FavoritosDao extends DAO<Favorito> {
  @override
  Favorito fromMap(Map<String, dynamic > map) {
    return Favorito.fromMap(map);
  }

  @override
  String get tableName => "favorito";

}