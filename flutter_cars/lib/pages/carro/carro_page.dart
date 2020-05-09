import 'package:flutter/material.dart';
import 'package:flutter_cars/models/carro.dart';

class CarroPage extends StatelessWidget {
  // const CarroPage({Key key}) : super(key: key);

  Carro carro;

  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMap,
          ),
          IconButton(
            onPressed: _onClickVideo,
            icon: Icon(Icons.videocam),
          ),
          PopupMenuButton<String>(
            onSelected: (String value) => _onClickPopUpMenu(value),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: "Editar",
                  child: Text("Editar"),
                ),
                PopupMenuItem(
                  value: "Deletar",
                  child: Text("Deletar"),
                ),
                PopupMenuItem(
                  value: "Shared",
                  child: Text("Shared"),
                )
              ];
            },
          )
        ],
      ),
      body: _body(carro),
    );
  }

  _body(Carro carro) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Image.network(carro.urlFoto),
    );
  }

  void _onClickMap() {}

  void _onClickVideo() {}

  _onClickPopUpMenu(String value) {
    switch (value) {
      case 'Editar':
        print(value);
        break;
      case 'Shered':
        print(value);
        break;
      case 'Deletar':
        print(value);
        break;
      default:
    }
  }
}
