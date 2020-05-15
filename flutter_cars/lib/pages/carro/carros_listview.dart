import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/pages/carro/carro_page.dart';
import 'package:flutter_cars/utils/nav.dart';

class CarrosListView extends StatelessWidget {
  List<Carro> carros;

  CarrosListView(this.carros);

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: carros.length,
          itemBuilder: (BuildContext context, int index) {
            Carro carro = carros[index];
            return Card(
              color: Colors.green[200],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: carro.urlFoto ??
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDeC_pIl9rURI0CLKa70og1CQOv-JMH8LzLpN5pDC6EO214Mu9Eg&s",
                        width: 250,
                      ),
                    ),
                    Text(
                      carro.nome ?? "Sem nome",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      carro.descricao ?? "Sem descrição",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('Detalhes'),
                          onPressed: () {
                            _onClickDetalhes(context, carro);
                          },
                        ),
                        FlatButton(
                          child: const Text('Share'),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  void _onClickDetalhes(BuildContext context, Carro carro) {
    push(context, CarroPage(carro));
  }
}
