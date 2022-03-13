import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leitor_manga/ApiAccess.dart';
import 'package:leitor_manga/Menu/MenuBar.dart';
import 'package:leitor_manga/State/AppState.dart';
import 'package:provider/provider.dart';

class CapituloViewer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
        builder: (context,state,child){ return Scaffold(
            appBar: AppBar(
                title: Text('Leitor')
            ),
            body: Column(
              children: [
                Expanded(child: ListView(children: state.capituloAtual.map((pagina){ return Image.network('${ApiAccess.apiHost}${pagina['path']}'); }).toList()))
              ]
            )
        );}
    );
  }

}