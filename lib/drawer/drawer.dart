import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:projeto_novo/front/pedidos.dart';
import 'package:projeto_novo/front/cardapio.dart';
import 'package:projeto_novo/front/apiConsumo.dart';



class DrawerPadrao extends StatelessWidget {
  Widget build(BuildContext context){
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(

              child: Text('Restaurante Z'),
              decoration: BoxDecoration(
                color: Color(0xffCD3301),
              ),
            ),
            ListTile(
              title: Text('Cardápio'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cardapio()),
                );
              },
            ),
            ListTile(
              title: Text('Pedidos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pedidos()),
                );
              },),
            ListTile(
              title: Text('API'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => APIConsumo()),
                );
              },),
            ListTile(
              title: Text('Sair'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },),
          ],
        ),
      );
  }
}