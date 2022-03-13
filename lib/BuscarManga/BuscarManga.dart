import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:leitor_manga/BuscarManga/GrupoBuscarManga.dart';
import 'package:leitor_manga/BuscarManga/ListaResultadosBusca.dart';
import 'package:leitor_manga/Menu/MenuBar.dart';
import 'package:provider/provider.dart';

import '../State/AppState.dart';

class BuscarManga extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buscar mangá')),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Container(
                color: HexColor('#222244'),
                child: ListView(
                  children: [
                    Container(
                      color: HexColor('#222244'),
                      child: GrupoBuscarManga(),
                    ),
                    ListaResultadosBusca(),
                  ],
              )
            )),
            MenuBar()
          ]
      )
    );
  }

}