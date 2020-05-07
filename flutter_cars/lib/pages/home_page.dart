import 'package:flutter/material.dart';
import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/services/api_response.dart';
import 'package:flutter_cars/services/carro_api.dart';
import 'package:flutter_cars/utils/alert.dart';
import 'package:flutter_cars/widgets/drawer_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    Future<List<Carro>> _future = CarroApi.getCarros();
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Não foi possivel acessar os dados.",
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
              ),
            ),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print(snapshot.data);
          List<Carro> carros = snapshot.data;
          print(carros);
          return _listView(carros);
        }
      },
    );
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
                        carro.urlFoto??"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDeC_pIl9rURI0CLKa70og1CQOv-JMH8LzLpN5pDC6EO214Mu9Eg&s",
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
                      carro.descricao??"Sem descrição",
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
                          onPressed: () {/* ... */},
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
}
