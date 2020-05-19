import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cars/models/carro.dart';
import 'package:flutter_cars/pages/carro/carros_bloc.dart';
import 'package:flutter_cars/pages/carro/carros_listview.dart';
import 'package:flutter_cars/utils/event_bus.dart';
import 'package:flutter_cars/widgets/test_error.dart';

class CarrosPage extends StatefulWidget {
  String tipo;
  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  List<Carro> carros;

  final _bloc = CarrosBloc();

  StreamSubscription<Event> subscription;

  @override
  void initState() {
    super.initState();
    _bloc.loadCarros(widget.tipo); 
    final bus = EventBus.get(context);
    subscription = bus.stream.listen((Event s) {
      print("Event $s");
      _bloc.loadCarros(widget.tipo);
    } );
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
    return _bloc.loadCarros(widget.tipo);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    subscription.cancel();
  }
}
