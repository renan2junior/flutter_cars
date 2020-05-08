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
}
