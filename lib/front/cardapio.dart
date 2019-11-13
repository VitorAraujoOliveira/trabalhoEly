import 'package:flutter/material.dart';


import 'dart:async';

import 'package:projeto_novo/model/CardapioLista.dart';
import 'package:projeto_novo/model/PedidosLista.dart';
import 'package:sqflite/sqflite.dart';



import 'package:projeto_novo/drawer/drawer.dart';

class Cardapio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cardápio"),
          backgroundColor: Color(0xffCD3301),
        ),
        body: CardapioList(),
        drawer: DrawerPadrao());
  }
}

class CardapioList extends StatelessWidget {
  // Open the database and store the reference.
  final Future<Database> database = openDatabase(
    'restaurante.db',
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      db.execute(
          "CREATE TABLE pedidos(id INTEGER PRIMARY KEY, pedido TEXT, valor DOUBLE, mesa INTEGER, imagem TEXT);");
      return db.execute(
          "CREATE TABLE cardapio(id INTEGER PRIMARY KEY, pedido TEXT, valor DOUBLE, mesa INTEGER, imagem TEXT);");
    },
    version: 1,
  );

  Future<void> alteraBanco() async {
    final Database db = await database;
    await db.rawQuery('Alter Table Cardapio add imagem TEXT');
  }

  // Define a function that inserts dogs into the database
  Future<void> inserttCardapio(CardapioLista cardapio) async {
    // Get a reference to the database.
    final Database db = await database;

    await db.insert(
      'cardapio',
      cardapio.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> inserttPedido(PedidosLista pedidos) async {
    final Database db = await database;

    print(pedidos);
    await db.insert(
      'pedidos',
      pedidos.toMap(),
      //conflictAlgorithm: ConflictAlgorithm.values,
    );
  }

  //inserttCardapio();
  // Create a Dog and add it to the dogs table.
  final picanha = CardapioLista(
    id: 0,
    pedido: 'Picanha Acebolada ',
    valor: 70.96,
    mesa: 1,
    imagem: 'picanha.png',
  );

  final macarronada = CardapioLista(
    id: 1,
    pedido: 'Macarronada do Chef',
    valor: 32.50,
    mesa: 1,
    imagem: 'macarronada.jpg',
  );

  final suco1 = CardapioLista(
    id: 2,
    pedido: 'Suco de Laranja',
    valor: 8.50,
    mesa: 1,
    imagem: 'suco_laranja.png',
  );

  final suco2 = CardapioLista(
    id: 3,
    pedido: 'Suco de Morango',
    valor: 8.50,
    mesa: 1,
    imagem: 'suco_morango.png',
  );

  final skol = CardapioLista(
    id: 4,
    pedido: 'Cerveja Skol',
    valor: 6.50,
    mesa: 1,
    imagem: 'skol.png',
  );

  final refri = CardapioLista(
    id: 5,
    pedido: 'Refrigerante Coca-Cola',
    valor: 6.50,
    mesa: 1,
    imagem: 'refri.png',
  );

  Widget build(BuildContext context) {
    //alteraBanco();

    inserttCardapio(picanha);
    inserttCardapio(macarronada);
    inserttCardapio(suco1);
    inserttCardapio(suco2);
    inserttCardapio(skol);
    inserttCardapio(refri);

    // A method that retrieves all the dogs from the dogs table.
    Future<List<CardapioLista>> geraCardapio() async {
      // Get a reference to the database.
      final Database db = await database;

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('cardapio');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      return List.generate(maps.length, (i) {
        return CardapioLista(
          id: maps[i]['id'],
          pedido: maps[i]['pedido'],
          valor: maps[i]['valor'],
          mesa: maps[i]['mesa'],
          imagem: maps[i]['imagem'],
        );
      });
    }

//  allItems = [{'id': 0, 'pedido': 'Picanha Acebolada' , 'valor': 70.96, 'mesa': 1, 'imagem': 'picanha.png'},
//   {'id': 1, 'pedido': 'Macarronada do Chef', 'valor': 32.5, 'mesa': 1, 'imagem': 'macarronada.jpg'},
//   {'id': 2, 'pedido': 'Suco de Laranja', 'valor': 8.5, 'mesa': 1, 'imagem': 'suco_laranja.png'},
//   {'id': 3, 'pedido': 'Suco de Morango', 'valor': 8.5, 'mesa': 1, 'imagem': 'suco_morango.png'},
//   {'id': 4, 'pedido': 'Cerveja Skol', 'valor': 6.5, 'mesa': 1, 'imagem': 'skol.png'}];

    Future<dynamic> pegaDados() async {
      var allItems = await geraCardapio();

      return allItems.map((allItems) => allItems.toMap());
    }

    return FutureBuilder(
      future: pegaDados(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
                  leading: Image.asset(
                    "assets/" + objeto[index]['imagem'],
                    fit: BoxFit.contain,
                  ),
                  title: Text(objeto[index]['pedido']),
                  trailing: Text(objeto[index]['valor'].toString()),
                  onTap: () async {
                    print(objeto[index]);

                    final pedidoA = PedidosLista(
                      id: null, //objeto[index]['id'],
                      pedido: objeto[index]['pedido'],
                      valor: objeto[index]['valor'],
                      mesa: objeto[index]['mesa'],
                      imagem: objeto[index]['imagem'],
                    );

                    await inserttPedido(pedidoA);
                  },
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          throw snapshot.error;
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
