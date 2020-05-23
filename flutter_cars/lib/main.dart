import 'package:flutter/material.dart';
import 'package:flutter_cars/pages/splash/splash_page.dart';
import 'package:flutter_cars/utils/event_bus.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<EventBus>(
          create: (contex) => EventBus(),
          dispose: (contex, eventBus) => eventBus.dispose(),
        ),
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
