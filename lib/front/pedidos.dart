
import 'package:flutter/material.dart';
import 'package:projeto_novo/front/cardapio.dart';

import 'package:flutter/material.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:projeto_novo/model/PedidosLista.dart';
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

      final Future<Database> database = openDatabase('restaurante.db');

      Future<List<PedidosLista>> geraPedidos() async {
        // Get a reference to the database.
        final Database db = await database;

        // Query the table for all The Dogs.
        final List<Map<String, dynamic>> maps = await db.query('pedidos');

        // Convert the List<Map<String, dynamic> into a List<Dog>.
        return List.generate(maps.length, (i) {
          return PedidosLista(
            id: maps[i]['id'],
            pedido: maps[i]['pedido'],
            valor: maps[i]['valor'],
            mesa: maps[i]['mesa'],
            imagem: maps[i]['imagem'],
          );
        });
      }



    Future<void> alteraPedido(PedidosLista pedidos) async{
      // Get a reference to the database.
      final Database db = await database;

      // Insert the Dog into the correct table. You might also specify the 
      // `conflictAlgorithm` to use in case the same dog is inserted twice. 
      // 
      // In this case, replace any previous data.
      await db.insert(
        'pedidos',
        pedidos.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

    }

      Future<void> deletaPedido(PedidosLista pedidos) async{
      // Get a reference to the database.
      final Database db = await database;

      // Insert the Dog into the correct table. You might also specify the 
      // `conflictAlgorithm` to use in case the same dog is inserted twice. 
      // 
      // In this case, replace any previous data.
      await db.insert(
        'pedidos',
        pedidos.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

    }
    



    Future<dynamic> pegaDados() async{
      var allItems = await geraPedidos();

      return allItems.map((allItems) => allItems.toMap());
    }



    return FutureBuilder(
          future: pegaDados(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              print(snapshot.data);
              var objeto = [];

              for (var i in snapshot.data) {
                objeto.add(i);
              }
              
              print(objeto);
              return Container(
                  child: ListView.builder(
                itemCount: objeto.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset("assets/"+ objeto[index]['imagem'], fit: BoxFit.contain,),
                    title: Text(objeto[index]['pedido']),
                    trailing: Text(objeto[index]['valor'].toString()),
                    onTap: (){
                      print("aqui"+index.toString());
                    },
                  );
                },
                  ),
              );
            }
            else if(snapshot.hasError){
              throw snapshot.error;
            }
            else{
              return Center(child: CircularProgressIndicator());
            }
          },
        );



   }
}