import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../State/AppState.dart';

class GrupoBuscarManga extends StatelessWidget{
  TextEditingController busca = TextEditingController();

  void pesquisar(BuildContext context){
    Provider.of<AppState>(context,listen: false).buscar_mangas(this.busca.text);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(child: Container(
              width: 200,
              height: 40,
              margin: EdgeInsets.fromLTRB(10,10,10,10),
              child: TextField(
                  controller: this.busca,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10,10,10,10),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      filled: true,
                      fillColor: HexColor('#ffffff'),
                      hintText: 'Digite o nome do mangá')
              )
          )),
          Container(
              margin: EdgeInsets.fromLTRB(0,0,10,0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(20,40),
                  ),
                  onPressed: () => this.pesquisar(context),
                  child: Text('Buscar')
              )
          )
        ]
    );
  }

}