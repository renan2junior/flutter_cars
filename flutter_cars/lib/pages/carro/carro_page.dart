import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/pages/carro/carro_form_page.dart';
import 'package:flutter_cars/pages/favoritos/favoritos_service.dart';
import 'package:flutter_cars/services/api_response.dart';
import 'package:flutter_cars/services/carro_api.dart';
import 'package:flutter_cars/services/loripsum_api.dart';
import 'package:flutter_cars/utils/alert.dart';
import 'package:flutter_cars/utils/nav.dart';

class CarroPage extends StatefulWidget {
  // const CarroPage({Key key}) : super(key: key);

  Carro carro;
  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  ApiBloc _bloc = ApiBloc();

  Color color = Colors.grey;

  Carro get carro => widget.carro;

  @override
  void initState() {
    super.initState();
    _bloc.fetch();
    FavoritosService.isFavorito(carro).then((isFavorito) {
      setState(() {
        color = isFavorito ? Colors.red : Colors.grey;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
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
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          CachedNetworkImage(
              imageUrl: widget.carro.urlFoto ??
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDeC_pIl9rURI0CLKa70og1CQOv-JMH8LzLpN5pDC6EO214Mu9Eg&s"),
          _bloco1(),
          SizedBox(
            height: 10,
          ),
          _bloco2(),
        ],
      ),
    );
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.carro.nome,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.carro.tipo,
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                size: 30,
                color: color,
              ),
              onPressed: _onClickFavotite,
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: _onClickShare,
            )
          ],
        ),
      ],
    );
  }

  Column _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.carro.descricao),
        SizedBox(
          height: 10,
        ),
        StreamBuilder<String>(
          stream: _bloc.stream,
          builder: (BuildContext context, AsyncSnapshot snap) {
            if (!snap.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return (Text(
              snap.data,
              style: TextStyle(color: Colors.red),
            ));
          },
        ),
      ],
    );
  }

  void _onClickMap() {}

  void _onClickVideo() {}

  void deletar() async {
    ApiResponse<bool> response = await CarroApi.delete(carro);
    if (response.ok) {
      alert(
        context,
        "Carro deletado com sucesso",
        callback: () {
          pop(context);
        },
      );
    } else {
      alert(context, response.msg);
    }
  }

  _onClickPopUpMenu(String value) {
    switch (value) {
      case 'Editar':
        push(
            context,
            CarroFormPage(
              carro: carro,
            ));
        break;
      case 'Shered':
        print(value);
        break;
      case 'Deletar':
        deletar();
        break;
      default:
    }
  }

  void _onClickFavotite() async {
    bool favorito = await FavoritosService.Favoritar(carro);
    setState(() {
      color = favorito ? Colors.red : Colors.grey;
    });
  }

  void _onClickShare() {}

  @override
  void dispose() {
    super.dispose();
    _bloc.diposed();
  }
}
