import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

import 'MenuItem.dart';

class MenuBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(height: 75,color: HexColor('#222255'),child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MenuItem('lib/assets/favoritos.png','favoritos'),
          MenuItem('lib/assets/buscar.png','buscar_manga'),
          MenuItem('lib/assets/logout.png','logout'),
          MenuItem('lib/assets/downloads.png','downloads')
    ]));
  }
  
}