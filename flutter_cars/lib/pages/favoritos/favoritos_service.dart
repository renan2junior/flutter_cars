import 'package:flutter/material.dart';
import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/models/favorito.dart';
import 'package:flutter_cars/pages/carro/carro_dao.dart';
import 'package:flutter_cars/pages/favoritos/favoritos_bloc.dart';
import 'package:flutter_cars/pages/favoritos/favoritos_dao.dart';
import 'package:provider/provider.dart';

class FavoritosService {
  static Future<bool> Favoritar(BuildContext context,  Carro carro) async {
    Favorito favorito = Favorito(id: carro.id, nome: carro.descricao);
    final dao = FavoritosDao();
    bool exist = await dao.exists(carro.id);
    if (exist) {
      dao.delete(carro.id);
      // dao.findAll().then((list) => print(list));
      Provider.of<FavoritosBloc>(context, listen: false).fetch();
      return false;
    } else {
      dao.save(favorito);
      // dao.findAll().then((list) => print(list));
      Provider.of<FavoritosBloc>(context, listen: false).fetch();
      return true;
    }
  }

  static Future<List<Carro>> getCarros() async {
    List<Carro> carros = await CarroDAO()
        .query("select * from carro c, favorito f where c.id = f.id");
    return carros;
  }

  static Future<bool> isFavorito(Carro carro) async {
    final dao = FavoritosDao();
    final exist = await dao.exists(carro.id);
    return exist;
  }
}
