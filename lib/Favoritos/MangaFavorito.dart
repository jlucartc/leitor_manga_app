import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../ApiAccess.dart';
import '../State/AppState.dart';

class MangaFavorito extends StatelessWidget{
  double itemHeight = 0;
  HexColor backgroundColor = HexColor('#ffffff');
  HexColor textColor = HexColor('#000000');
  String titulo = '';
  String status = '';
  String capaPath = '';
  int mangaId = 0;

  MangaFavorito({required int mangaId, double itemHeight = 100, String titulo = 'Titulo do item', String status = 'Finalizado', String capaPath = 'lib/assets/page.png', String backgroundColorString = '#ffffff', String textColorString = '#000000'}){
    this.itemHeight = itemHeight;
    this.backgroundColor = HexColor(backgroundColorString);
    this.textColor = HexColor(textColorString);
    this.titulo = titulo;
    this.status = status;
    this.capaPath = capaPath;
    this.mangaId = mangaId;
  }

  void verManga(context){
    Provider.of<AppState>(context,listen: false).atualiza_manga_atual(this.mangaId);
    Navigator.pushNamed(context,'ver_manga');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => verManga(context),
        child: Container(color: this.backgroundColor, child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
          MangaImagem(this.itemHeight,this.backgroundColor,this.capaPath),
          MangaInformacoes(this.itemHeight,this.backgroundColor,this.titulo,this.status)
    ])));
  }

}

class MangaImagem extends StatelessWidget{
  double itemHeight = 0;
  HexColor backgroundColor = HexColor('#ffffff');
  String imagePath = '';


  MangaImagem(double itemHeight, HexColor backgroundColor, String imagePath){
    this.itemHeight = itemHeight;
    this.backgroundColor = backgroundColor;
    this.imagePath = imagePath;
  }

  Future<Widget> verificaImagem(String url) async{
    return await http.get(Uri.parse(url)).then((response){
      if(response.statusCode == 200){
        return Image.network(
            url,
            fit: BoxFit.fill,
            width: this.itemHeight/2,
            height: this.itemHeight/2);
      }else{
        return Image.asset(
            'lib/assets/page.png',
            fit: BoxFit.fill,
            width: this.itemHeight/2,
            height: this.itemHeight/2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.itemHeight,
        padding: EdgeInsets.fromLTRB(15,this.itemHeight/4,10,this.itemHeight/4),
        color: this.backgroundColor,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(this.itemHeight),
            child: FutureBuilder(
              future: this.verificaImagem('${ApiAccess.apiHost}${this.imagePath}'),
              builder: (context,snapshot){
                if(snapshot.data == null){
                  return Image.asset(
                      'lib/assets/page.png',
                      fit: BoxFit.fill,
                      width: this.itemHeight/2,
                      height: this.itemHeight/2);
                }else {
                  return snapshot.data as Widget;
                }
              })));
  }

}

class MangaInformacoes extends StatelessWidget{
  double itemHeight = 0;
  HexColor backgroundColor = HexColor('#ffffff');
  String titulo = '';
  String subtitulo = '';

  MangaInformacoes(double itemHeight, HexColor backgroundColor, String titulo, String subtitulo){
    this.itemHeight = itemHeight;
    this.backgroundColor = backgroundColor;
    this.titulo = titulo;
    this.subtitulo = subtitulo;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.fromLTRB(10,this.itemHeight/4,10,10),
            height: this.itemHeight,
            color: this.backgroundColor,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${this.titulo}',
                      style: TextStyle(fontSize: 24, color: HexColor('#ffffff'))
                  ),
                  Text(
                      '${this.subtitulo}',
                      style: TextStyle(fontSize: 16, color: HexColor('#ffffff'))
                  )
                ]
            )
        )
    );
  }

}