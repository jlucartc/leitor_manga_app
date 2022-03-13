import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiAccess {
  static final apiHost = "http://192.168.1.8:3000";
  static final dummyImagePath = '/dummy.png';

  final _apiMethods = {
    "cadastro": "/api/usuario/cadastrar",
    "login": "/api/usuario/login",
    "buscar": "/api/manga/buscar",
    "ler_manga": "/api/manga/ler",
    "favoritos": "/api/usuario/favoritos",
    "ver_manga": "/api/manga/ver",
    "favoritar": "/api/manga/favoritar",
    "desfavoritar": "/api/manga/desfavoritar"
  };

  Future<Map> realiza_login(email,password){
    var params = {'email': email, 'password': password};
    var resultado = _faz_requisicao("login",params);
    return resultado.then((res){ return {'status' : res.statusCode, 'token' : jsonDecode(res.body)['token'] };} );
  }

  Future<Response> realiza_cadastro(email,password,password_confirmation){
    var params = {'email': email, 'password': password, 'password_confirmation': password_confirmation};
    var resultado = _faz_requisicao("login",params);
    return resultado;
  }

  Future<List> favoritos(String token){
    var params = {'token': token};
    var resultado = _faz_requisicao("favoritos",params);
    return resultado.then((res){ return jsonDecode(res.body)['favoritos']; });
  }

  Future<List> buscar_mangas(String busca, String token){
    var params = {'busca': busca, 'token': token};
    var resultado = _faz_requisicao("buscar",params);
    return resultado.then((res){ return jsonDecode(res.body)['resultados']; });
  }

  Future<Map> ver_manga(String manga_id, String token){
    var params = {'manga_id': manga_id, 'token': token};
    var resultado = _faz_requisicao("ver_manga",params);
    return resultado.then((res){ return jsonDecode(res.body);});
  }

  Future<bool> favoritar_manga(String mangaId, String token){
    var params = {'manga_id': mangaId, 'token': token};
    var resultado = _faz_requisicao("favoritar",params);
    return resultado.then((res){ return res.statusCode == 200;});
  }

  Future<bool> desfavoritar_manga(String mangaId, String token){
    var params = {'manga_id': mangaId, 'token': token};
    var resultado = _faz_requisicao("desfavoritar",params);
    return resultado.then((res){ return res.statusCode == 200;});
  }

  Future<List> ler_manga(String manga_id, String sequencia_capitulo, String token){
    var params = {'manga_id': manga_id, 'sequencia_capitulo': sequencia_capitulo, 'token': token};
    var resultado = _faz_requisicao("ler_manga",params);
    return resultado.then((res){  return jsonDecode(res.body)['paginas']; });
  }

  Future<Response> _faz_requisicao(metodo,params) async{
    var url = Uri.parse("${ApiAccess.apiHost}${_apiMethods[metodo]}");
    var response = await http.post(url,body:params);
    return response;
  }

}