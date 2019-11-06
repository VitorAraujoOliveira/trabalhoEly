
import 'package:flutter/material.dart';
import 'package:projeto_novo/front/cardapio.dart';

import 'package:flutter/material.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class Pedidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pedidos"),backgroundColor: Color(0xffCD3301),),
      body: PedidoList(),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
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
              },),
            ListTile(
              title: Text('Sair'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },),
          ],
        ),
      ),
    );
  }
}

class PedidoList extends StatelessWidget{
   Widget build(BuildContext context){
     return ListView();
   }
}