import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../State/AppState.dart';
import 'MangaFavorito.dart';

class ListaFavoritos extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context,state,child){
      state.atualiza_favoritos();
      return Expanded(
          child: Container(
              color: HexColor('#222244'),
              child: ListView(
                children: state.favoritos.asMap().entries.map((favorito){
                  return MangaFavorito(
                      itemHeight: 100,
                      titulo: favorito.value['titulo'],
                      status: '${favorito.value['finalizado'] ? 'Finalizado' : 'Em andamento'}',
                      capaPath: favorito.value['capa_path'],
                      mangaId: favorito.value['id'],
                      backgroundColorString: (favorito.key % 2 == 0) ? '#222244': '#444466'
                  );
                }).toList()
              )
          )
      );
    });
  }
}