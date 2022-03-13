import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:leitor_manga/BuscarManga/ResultadoBusca.dart';
import 'package:leitor_manga/State/AppState.dart';
import 'package:provider/provider.dart';

class ListaResultadosBusca extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context,state,child){
      return Container(
            color: HexColor('#111111'),
            child: Column(
                children: state.resultadosPesquisa.asMap().entries.map((entry){
                  return ResultadoBusca(
                      entry.value['id'],
                      entry.value['titulo'],
                      entry.value['finalizado'],
                      entry.value['capa_path'],
                      (entry.key % 2 == 0) ? HexColor('#222244') : HexColor('#444466')
                  );
                }).toList()
            )
      );
    });
  }

}