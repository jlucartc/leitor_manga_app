import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget{
  String iconPath  = 'lib/assets/page.png';
  String routeName = '';

  MenuItem(String iconPath, String routeName){
    this.iconPath = iconPath;
    this.routeName = routeName;
  }

  void navigateTo(BuildContext context, String routeName){
    Navigator.pushNamedAndRemoveUntil(context,routeName,ModalRoute.withName(routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: GestureDetector(
        onTap: () => this.navigateTo(context,this.routeName),
        child: Container(
                  margin: EdgeInsets.fromLTRB(0,10,0,0),
                  child: Image.asset(
                      this.iconPath,
                      fit: BoxFit.fitHeight
                  )
        )
    ));
  }

}