import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../State/AppState.dart';
import 'CapituloItem.dart';

class MangaChapterList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context,state,child){
      return Column(
          children: (state.mangaAtual['capitulos'] as List).asMap().entries.map((capitulo){
            return CapituloItem(state.mangaAtual['manga']['id'],capitulo.value['titulo'],capitulo.value['sequencia'],colorString: (capitulo.key % 2 == 0) ? '#444466' : '#222244',);
      }).toList());
    });
  }

}