import 'package:flutter/material.dart';
import 'package:flutter_cars/models/usuario.dart';
import 'package:flutter_cars/pages/carro/home_page.dart';
import 'package:flutter_cars/utils/sql/db_helper.dart';
import 'package:flutter_cars/pages/login/login_page.dart';
import 'package:flutter_cars/utils/nav.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initFutures();
  }

  Future<Usuario> getUser() => Usuario.get();

  Future initDb() => DatabaseHelper.getInstance().db;

  Future initSplash() => Future.delayed(Duration(seconds: 3));

  void initFutures() {
    Future.wait([initSplash(), getUser(), initDb() ]).then(
      (value){
        Usuario user = value[1];
        if(user!=null){
          push(context, HomePage());
        }else{
          push(context, LoginPage());
        }
        
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
