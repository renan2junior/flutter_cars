import 'package:flutter/material.dart';
import 'package:flutter_cars/pages/home_page.dart';
import 'package:flutter_cars/pages/login_page.dart';
import 'package:flutter_cars/utils/nav.dart';

class DrawerList extends StatefulWidget {
  DrawerList({Key key}) : super(key: key);

  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Renan Junior"),
              accountEmail: Text("renan2junior@gmail.com"),
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

  _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
