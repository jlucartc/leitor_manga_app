import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:leitor_manga/State/AppState.dart';
import 'package:leitor_manga/Menu/MenuBar.dart';
import 'package:provider/provider.dart';

import 'ListaFavoritos.dart';
import 'MangaFavorito.dart';

class Favoritos extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Favoritos')),
        body: Column(children: [
          ListaFavoritos(),
          MenuBar()
        ])
    );
  }
}