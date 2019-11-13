import 'dart:convert';

import 'package:flutter/material.dart';

import 'dart:convert' show utf8;
import 'dart:async';

import 'package:http/http.dart' as http;


import 'package:projeto_novo/drawer/drawer.dart';

class APIConsumo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cardápio"),
          backgroundColor: Color(0xffCD3301),
        ),
        body: ConsumoAPI(),
        drawer: DrawerPadrao());
  }
}



class ConsumoAPI extends StatelessWidget{

  var url = 'http://sistemaagely.com.br/getArquivo?file=produtos.json';

  Future<List> dadosAPI() async{
    var response = await http.get(url);
    return jsonDecode(response.body);
  }
  

  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dadosAPI(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data);

          return Container(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(snapshot.data[index]['marca']),
                  title: Text(snapshot.data[index]['descricao']),
                  trailing: Text("Valor: " + snapshot.data[index]['precoVenda'].toString()),
                  onTap: () async {

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