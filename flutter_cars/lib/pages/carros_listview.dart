import 'package:flutter/material.dart';
import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/pages/carro_page.dart';
import 'package:flutter_cars/services/carro_api.dart';
import 'package:flutter_cars/utils/nav.dart';

class CarrosListView extends StatefulWidget {
  // CarrosListView({Key key}) : super(key: key);

  String tipo;
  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  List<Carro> carros;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    await CarroApi.getCarros(widget.tipo).then((List<Carro> carros) {
      setState(() {
        this.carros = carros;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (this.carros == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return _listView(carros);
    }
  }

  Container _listView(List<Carro> carros) {
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
                      child: Image.network(
                        carro.urlFoto ??
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
                            _onClickDetalhes(carro);
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

  @override
  bool get wantKeepAlive => true;

  void _onClickDetalhes(Carro carro) {
    push(context, CarroPage(carro));
  }
}
