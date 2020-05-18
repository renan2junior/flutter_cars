import 'package:flutter/material.dart';
import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/pages/carro/carros_listview.dart';
import 'package:flutter_cars/pages/favoritos/favoritos_bloc.dart';
import 'package:flutter_cars/widgets/test_error.dart';

class FavoritosPage extends StatefulWidget {

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  List<Carro> carros;

  final _bloc = FavoritosBloc();

  @override
  void initState() {
    super.initState();
    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return TestError("Ocorreu um erro na conexão.");
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // print(snapshot.data);
          List<Carro> carros = snapshot.data;
          // print(carros);
          return RefreshIndicator(
            child: CarrosListView(carros),
            onRefresh: _onRefresh,
          );
        }
      },
    );
  }

  Future<void> _onRefresh() {
    return _bloc.fetch();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
