import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:leitor_manga/ApiAccess.dart';
import 'package:leitor_manga/Favoritos/Favoritos.dart';
import 'package:provider/provider.dart';

import '../State/AppState.dart';

class LoginPage extends StatelessWidget{
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final ApiAccess api = ApiAccess();

  void fazer_login(context){
    var resultado = api.realiza_login(this.email.text,this.password.text);
    resultado.then((res){
      if(res['status'] == 200){
        Provider.of<AppState>(context, listen: false).atualiza_token(res['token']);
        Navigator.pushNamedAndRemoveUntil(context,'favoritos',ModalRoute.withName('favoritos'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
        builder: (context,state,child){
          if(state.token.isEmpty){
            return Scaffold(
                appBar: AppBar(
                          title: Text('MyApp')
                ),
                body: Container(
                  color: HexColor('#111111'),
                  child: Column(
                    children: [
                      Container(
                          height: 50,
                          margin: EdgeInsets.fromLTRB(10,20,10,10),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.bottom,
                            controller: this.email,
                            style: TextStyle(),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                filled: true,
                                fillColor: HexColor('#ffffff'),
                                hintText: 'Email'
                            )
                          )
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.fromLTRB(10,10,10,10),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.bottom,
                          obscureText: true,
                          controller: this.password,
                          style: TextStyle(),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                              filled: true,
                              fillColor: HexColor('#ffffff'),
                              hintText: 'Senha')
                      )),
                      Container(
                          margin: EdgeInsets.fromLTRB(10,10,10,0),
                          child: ElevatedButton(
                            onPressed: (){
                              this.fazer_login(context);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity,40)
                            ),
                            child: Text('Login')
                          )
                      )
                    ],
                )
            ));
          }else{
            return Favoritos();
          }
      }
    );
  }
}