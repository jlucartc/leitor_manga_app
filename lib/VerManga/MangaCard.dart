import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:leitor_manga/ApiAccess.dart';
import 'package:http/http.dart' as http;
import 'package:leitor_manga/State/AppState.dart';
import 'package:leitor_manga/VerManga/FavoriteButton.dart';
import 'package:provider/provider.dart';

class MangaCard extends StatelessWidget{
  String titulo = '';
  String descricao = '';
  String capaPath = '';
  double height = 150;
  bool finalizado = false;
  HexColor backgroundColor = HexColor('#222244');
  int mangaId = 0;

  MangaCard(String titulo, bool finalizado,String descricao, String capaPath, int mangaId){
    this.titulo = titulo;
    this.finalizado = finalizado;
    this.capaPath = capaPath;
    this.descricao = descricao;
    this.mangaId = mangaId;
  }

  Future<Widget> verificaImagem() async {
    return await http.get(Uri.parse('${ApiAccess.apiHost}/${this.capaPath}')).then((resultado){
      return ClipRRect(borderRadius: BorderRadius.circular(this.height),child: Image.network('${ApiAccess.apiHost}/${this.capaPath}',fit: BoxFit.fill));
    });
  }

  bool isFavorito(context,id){
    List ids = (Provider.of<AppState>(context,listen: false).favoritos as List).map((element){ return element['id']; }).toList();
    return ids.contains(id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: [
        Container(
          margin: EdgeInsets.fromLTRB(0,20,0,20),
          color: this.backgroundColor,
          width: this.height,
          height: this.height,
          child: FutureBuilder(
            future: this.verificaImagem(),
            builder: (context,snapshot){
              if(snapshot.data == null){
                return ClipRRect(borderRadius: BorderRadius.circular(this.height),child: Image.asset('lib/assets/page.png',fit: BoxFit.fill));
              }else{
                return snapshot.data as Widget;
              }
            }
          )
        ),
        FavoriteButton(this.isFavorito(context,this.mangaId))
      ]),
      Container(margin: EdgeInsets.fromLTRB(0,0,0,10), child: Text('${this.titulo}',style: TextStyle(color: HexColor('#ffffff'), fontSize: 24))),
      Container(margin: EdgeInsets.fromLTRB(0,0,0,20), child: Text('${this.finalizado ? 'Finalizado': 'Em andamento'}',style: TextStyle(color: HexColor('#eeeeee'), fontSize: 16))),
      Container(width: double.infinity, padding: EdgeInsets.fromLTRB(20,0,20,20), child: Text('Descrição: ${this.descricao}',style: TextStyle(color: HexColor('#ffffff'), fontSize: 14)))
    ]);
  }
}