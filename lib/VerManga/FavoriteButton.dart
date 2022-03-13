import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leitor_manga/State/AppState.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget{
  bool isFavorite = false;

  FavoriteButton(bool isFavorite){
    this.isFavorite = isFavorite;
  }

  void favorita(BuildContext context){
    int mangaId = Provider.of<AppState>(context,listen: false).mangaAtual['manga']['id'];
    Provider.of<AppState>(context,listen: false).favoritar_manga(mangaId);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Mangá adicionado aos favoritos!'), duration: Duration(seconds: 2)));
  }

  void desfavorita(BuildContext context){
    int mangaId = Provider.of<AppState>(context,listen: false).mangaAtual['manga']['id'];
    Provider.of<AppState>(context,listen: false).desfavoritar_manga(mangaId);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Mangá removido dos favoritos!'), duration: Duration(seconds: 2)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => this.isFavorite ? this.desfavorita(context) : this.favorita(context),
        child: Container(
            width: 50,
            height: 50,
            child: Image.asset(this.isFavorite? 'lib/assets/fav.png' : 'lib/assets/not_fav.png')
        )
    );
  }

}