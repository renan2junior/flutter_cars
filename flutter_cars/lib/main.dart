import 'package:flutter/material.dart';
import 'package:flutter_cars/pages/favoritos/favoritos_bloc.dart';
import 'package:flutter_cars/pages/splash/splash_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FavoritosBloc>(
          create: (context) => FavoritosBloc(),
          dispose: (context, bloc) => bloc.dispose(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white),
        home: SplashPage(),
      ),
    );
  }
}
