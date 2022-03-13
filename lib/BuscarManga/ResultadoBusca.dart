import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:leitor_manga/ApiAccess.dart';
import 'package:leitor_manga/State/AppState.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ResultadoBusca extends StatelessWidget{
  String titulo = '';
  bool status = false;
  String capaPath = '';
  HexColor backgroundColor = HexColor('#ffffff');
  int mangaId = 0;
  
  ResultadoBusca(int mangaId, String titulo, bool status, String capaPath, HexColor backgroundColor){
    this.titulo = titulo;
    this.status = status;
    this.capaPath = capaPath;
    this.backgroundColor = backgroundColor;
    this.mangaId = mangaId;
  }

  void verManga(BuildContext context){
    Provider.of<AppState>(context,listen: false).atualiza_manga_atual(this.mangaId);
    Navigator.pushNamed(context,'ver_manga');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => this.verManga(context),
        child: Container(
          padding: EdgeInsets.fromLTRB(10,0,0,0),
          color: this.backgroundColor,
          child: Row(
            children: [
              ResultadoImagem(100,this.capaPath),
              ResultadoCard(this.titulo,this.status ? 'Finalizado' : 'Em andamento',100,this.backgroundColor)
            ]
          )
        )
    );
  }
  
}

class ResultadoImagem extends StatelessWidget{
  double itemHeight = 0;
  String imageUrl = '';

  ResultadoImagem(double itemHeight, String imageUrl){
    this.itemHeight = itemHeight;
    this.imageUrl = imageUrl;
  }

  Future<Widget> verificaImagem(){
    return http.get(Uri.parse('${ApiAccess.apiHost}${this.imageUrl}')).then((response){
      if(response.statusCode == 200){
        return ClipRRect(
            borderRadius: BorderRadius.circular(this.itemHeight),
            child: Image.network(
                '${ApiAccess.apiHost}${this.imageUrl}',
                width: this.itemHeight/2,
                height: this.itemHeight/2,
                fit: BoxFit.fill
            ),
        );
      }else{
        return ClipRRect(
          borderRadius: BorderRadius.circular(this.itemHeight),
          child: Image.asset(
              'lib/assets/page.png',
              width: this.itemHeight/2,
              height: this.itemHeight/2,
              fit: BoxFit.fill
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: this.verificaImagem(),
        builder: (context,snapshot){
          if(snapshot.data == null){
            return ClipRRect(
              borderRadius: BorderRadius.circular(this.itemHeight),
              child: Image.asset(
                  'lib/assets/page.png',
                  width: this.itemHeight/2,
                  height: this.itemHeight/2,
                  fit: BoxFit.fill
              ),
            );
          }else{
            return snapshot.data as Widget;
          }
    });
  }
}

class ResultadoCard extends StatelessWidget{
  String titulo = '';
  String subtitulo = '';
  double itemHeight = 0;
  HexColor backgroundColor = HexColor('#ffffff');

  ResultadoCard(String titulo, String subtitulo, double itemHeight, HexColor backgroundColor){
    this.titulo = titulo;
    this.subtitulo = subtitulo;
    this.itemHeight = itemHeight;
    this.backgroundColor = backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.fromLTRB(10, this.itemHeight/4, 10, 10),
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