import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/models/favorito.dart';
import 'package:flutter_cars/pages/carro/carro_dao.dart';
import 'package:flutter_cars/pages/favoritos/favoritos_dao.dart';

class FavoritosService {
  static Favoritar(Carro carro) async {
    Favorito favorito = Favorito(id: carro.id, nome: carro.descricao);
    final dao = FavoritosDao();
    bool exist = await dao.exists(carro.id);
    if (exist) {
      dao.delete(carro.id);
    } else {
      dao.save(favorito);
    }
    dao.findAll().then((list)=>print(list));
  }

  static Future<List<Carro>> getCarros() async{
    List<Carro> carros = await CarroDAO().query("select * from carro c, favorito f where c.id = f.id");
    return carros;
  } 
}
