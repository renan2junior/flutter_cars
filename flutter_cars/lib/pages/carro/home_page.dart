import 'package:flutter/material.dart';
import 'package:flutter_cars/pages/carro/carros_listview.dart';
import 'package:flutter_cars/pages/carro/carros_page.dart';
import 'package:flutter_cars/pages/favoritos/favoritos_page.dart';
import 'package:flutter_cars/services/carro_api.dart';
import 'package:flutter_cars/utils/alert.dart';
import 'package:flutter_cars/widgets/drawer_list.dart';
import 'package:flutter_cars/utils/prefs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initTabs();
  }

  _initTabs() async {
    int tabIdx = await Prefs.getInt("tab");

    _tabController = TabController(length: 4, vsync: this);

    setState(() {
      _tabController.index = tabIdx;
    });

    _tabController.addListener(() {
      Prefs.setInt("tab", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: _tabController == null
            ? null
            : TabBar(controller: _tabController, tabs: [
                Tab(
                  text: "Clássicos",
                ),
                Tab(
                  text: "Esportivos",
                ),
                Tab(
                  text: "Luxo",
                ),
                Tab(
                  text: "Favoritos",
                )
              ]),
      ),
      body: _tabController == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(
              controller: _tabController,
              children: <Widget>[
                CarrosPage(TipoCarro.classicos),
                CarrosPage(TipoCarro.esportivos),
                CarrosPage(TipoCarro.luxo),
                FavoritosPage(),
              ],
            ),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onClickAddCarros,
      ),
    );
  }

  void _onClickAddCarros() {
    alert(context, "Add carros");
  }
}
