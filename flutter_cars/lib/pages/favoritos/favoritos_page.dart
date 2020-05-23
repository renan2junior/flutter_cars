import 'package:flutter/material.dart';
import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/pages/carro/carros_listview.dart';
import 'package:flutter_cars/pages/favoritos/favoritos_service.dart';
import 'package:flutter_cars/widgets/test_error.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  List<Carro> carros;

  // final _bloc = FavoritosBloc();

  @override
  void initState() {
    super.initState();
    // FavoritosBloc _bloc = Provider.of<FavoritosBloc>(context, listen: false);
    // _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<QuerySnapshot>(
      stream: FavoritosService().stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return TestError("Ocorreu um erro na conexão.");
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // print(snapshot.data);
          List<Carro> carros =
              snapshot.data.documents.map((DocumentSnapshot document) {
            return Carro.fromMap(document.data);
          }).toList();
          // print(carros);
          return CarrosListView(carros);
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
