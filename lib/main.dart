import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leitor_manga/BuscarManga/BuscarManga.dart';
import 'package:leitor_manga/LerManga/CapituloViewer.dart';
import 'package:provider/provider.dart';
import 'State/AppState.dart';
import 'LoginPage/LoginPage.dart';
import 'Favoritos/Favoritos.dart';
import 'VerManga/VerManga.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => AppState(), child: MaterialApp(
      routes: {
        'favoritos': (BuildContext context) => Favoritos(),
        'ver_manga': (BuildContext context) => VerManga(),
        'buscar_manga': (BuildContext context) => BuscarManga(),
        'ler_manga': (BuildContext context) => CapituloViewer(),
        'logout': (BuildContext context){ Provider.of<AppState>(context,listen: false).fazer_logout(); return LoginPage(); }
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    ));
  }
}