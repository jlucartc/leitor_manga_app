import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:leitor_manga/State/AppState.dart';
import 'package:provider/provider.dart';

class CapituloItem extends StatelessWidget{
  String titulo = '';
  int sequencia = 0;
  int mangaId = 0;
  double height = 65;
  HexColor backgroundColor = HexColor('#222233');

  CapituloItem(int mangaId, String titulo, int sequencia, {String colorString = '#222233'}){
    this.mangaId = mangaId;
    this.titulo = titulo;
    this.sequencia = sequencia;
    this.backgroundColor = HexColor(colorString);
  }

  void lerManga(BuildContext context){
    int mangaId = Provider.of<AppState>(context,listen: false).mangaAtual['manga']['id'];
    Provider.of<AppState>(context,listen: false).atualiza_capitulo_atual(mangaId,this.sequencia);
    Navigator.pushNamed(context,'ler_manga');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => this.lerManga(context),
        child: Container(
            padding: EdgeInsets.fromLTRB(20,20,10,20),
            width: double.infinity,
            height: this.height,
            child: Text('${this.titulo}',
                style: TextStyle(
                    color: HexColor('#ffffff'),
                    fontSize: 16
                ),
                overflow: TextOverflow.ellipsis),
            color: this.backgroundColor)
    );
  }
  
}