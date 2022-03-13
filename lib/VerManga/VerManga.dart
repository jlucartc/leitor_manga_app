import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:leitor_manga/Menu/MenuBar.dart';
import 'package:provider/provider.dart';

import '../State/AppState.dart';
import 'MangaCard.dart';
import 'MangaChapterList.dart';

class VerManga extends StatelessWidget{
  HexColor backgroundColor = HexColor('#222244');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes')),
      body: Consumer<AppState>(builder: (context,state,child){
        print('MANGA ATUAL: ${state.mangaAtual['manga']['titulo']}');
        return Column(
          children: [
            Expanded(
                child: Container(color: this.backgroundColor,child: ListView(
                  children: [
                    MangaCard(
                        state.mangaAtual['manga']['titulo'],
                        state.mangaAtual['manga']['finalizado'],
                        state.mangaAtual['manga']['descricao'],
                        state.mangaAtual['manga']['capa_path'],
                        state.mangaAtual['manga']['id']
                    ),
                    MangaChapterList()
                  ])
            )),
            MenuBar()
          ],
        );
      })
    );
  }

}

class ChapterList {
}