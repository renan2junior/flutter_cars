import 'package:flutter/material.dart';
import 'package:flutter_cars/firebase/firebase_service.dart';
import 'package:flutter_cars/models/usuario.dart';
import 'package:flutter_cars/pages/login/login_page.dart';
import 'package:flutter_cars/utils/nav.dart';

class DrawerList extends StatefulWidget {
  DrawerList({Key key}) : super(key: key);

  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Usuario> future = Usuario.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
              future: future,
              builder: (BuildContext context, AsyncSnapshot<Usuario> snap) {
                Usuario user = snap.data;
                return user != null
                    ? _header(snap.data)
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
            ListTile(
              title: Text("Item 1"),
              trailing: Icon(Icons.arrow_forward),
              leading: Icon(Icons.add),
            ),
            ListTile(
              title: Text("Item 1"),
              trailing: Icon(Icons.arrow_forward),
              leading: Icon(Icons.add),
            ),
            ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.exit_to_app),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader _header(Usuario user) {
    return UserAccountsDrawerHeader(
      currentAccountPicture: user.urlFoto != null ? Image.network(user.urlFoto): FlutterLogo(),
      accountName: Text(user.nome ?? ""),
      accountEmail: Text(user.email),
    );
  }

  _onClickLogout(BuildContext context) {
    Usuario.clear();
    FirebaseService().logout();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
