import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leitor_manga/ApiAccess.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

class AppState extends ChangeNotifier{
  ApiAccess api_access = ApiAccess();
  Map mangaAtual = Map();
  List capituloAtual = List.empty();
  List favoritos = List.empty();
  List resultadosPesquisa = List.empty();
  String token = '';
  final preferences = SharedPreferences.getInstance();

  AppState() {
    this.preferences.then((sharedPreferences){
      this.mangaAtual = sharedPreferences.containsKey('manga_atual') ? jsonDecode(sharedPreferences.get('manga_atual') as String) : Map();
      this.capituloAtual = sharedPreferences.containsKey('capitulo_atual') ? jsonDecode(sharedPreferences.get('capitulo_atual') as String) : List.empty();
      this.favoritos = sharedPreferences.containsKey('favoritos') ? jsonDecode(sharedPreferences.get('favoritos') as String) : List.empty();
      this.token = sharedPreferences.containsKey('token') ? sharedPreferences.get('token') as String : '';
      notifyListeners();
    });
  }

  void fazer_logout(){
    this.token = '';
    this.preferences.then((sharedPreferences){
      sharedPreferences.setString('token',this.token);
      notifyListeners();
    });
  }

  void favoritar_manga(int mangaId){
    api_access.favoritar_manga(mangaId.toString(),this.token).then((response){
      this.atualiza_favoritos();
      notifyListeners();
    });
  }

  void desfavoritar_manga(int mangaId){
    api_access.desfavoritar_manga(mangaId.toString(),this.token).then((response){
      this.atualiza_favoritos();
      notifyListeners();
    });
  }

  void atualiza_token(String token){
    this.token = token;
    this.preferences.then((sharedPreferences){
      sharedPreferences.setString('token',this.token);
      notifyListeners();
    });
  }

  void atualiza_favoritos(){
    api_access.favoritos(this.token).then((updatedFavoritos){
      if(!DeepCollectionEquality().equals(updatedFavoritos,this.favoritos)){
        this.preferences.then((sharedPreferences){
          this.favoritos = updatedFavoritos;
          sharedPreferences.setString('favoritos',jsonEncode(this.favoritos));
          notifyListeners();
        });
      }
    });
  }

  void atualiza_manga_atual(int manga_id){
    api_access.ver_manga(manga_id.toString(),this.token).then((updatedMangaAtual){
      if(!DeepCollectionEquality().equals(updatedMangaAtual,this.mangaAtual)){
        this.preferences.then((sharedPreferences){
          this.mangaAtual = updatedMangaAtual;
          sharedPreferences.setString('mangaAtual',jsonEncode(this.mangaAtual));
          notifyListeners();
        });
      }
    });
  }

  void atualiza_capitulo_atual(int manga_id, int sequencia_capitulo){
    api_access.ler_manga(manga_id.toString(), sequencia_capitulo.toString(),this.token).then((updatedCapituloAtual){
      if(!DeepCollectionEquality().equals(updatedCapituloAtual,this.capituloAtual)){
        this.preferences.then((sharedPreferences){
          this.capituloAtual = updatedCapituloAtual;
          sharedPreferences.setString('capitulo_atual',jsonEncode(this.capituloAtual));
          notifyListeners();
        });
      }
    });
  }

  void buscar_mangas(String pesquisa){
    api_access.buscar_mangas(pesquisa,this.token).then((resultados){
      this.resultadosPesquisa = resultados;
      notifyListeners();
    });
  }

}