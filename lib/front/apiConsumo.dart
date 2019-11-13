import 'dart:convert';

import 'package:flutter/material.dart';

import 'dart:convert' show utf8;
import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:projeto_novo/drawer/drawer.dart';
import 'package:barcode_flutter/barcode_flutter.dart';

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

class ConsumoAPI extends StatelessWidget {
  var url = 'http://sistemaagely.com.br/getArquivo?file=produtos.json';

  Future<List> dadosAPI() async {
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
                return ExpansionTile(
                  leading: Text(snapshot.data[index]['marca']),
                  title: Text(snapshot.data[index]['descricao']),
                  trailing: Text("Valor: " +
                      snapshot.data[index]['precoVenda'].toString()),
                  children: <Widget>[
                    Container(
                      child: BarCodeImage(
                        params: Code39BarCodeParams(
                          snapshot.data[index]["codBarras"],
                          lineWidth:
                              2.0, // width for a single black/white bar (default: 2.0)
                          barHeight:
                              90.0, // height for the entire widget (default: 100.0)
                          withText:
                              true, // Render with text label or not (default: false)
                        ),
                        onError: (error) {
                          // Error handler
                          print('error = $error');
                        },
                      ),
                      
                    ),
                    Container(child: Text("Cod-Referencia: " + snapshot.data[index]["codReferencia"]),padding: const EdgeInsets.all(18.0),),
                    Container(child: Text("Saldo Estoque: " + snapshot.data[index]["saldoEstoque"].toString()),padding: const EdgeInsets.all(18.0),),
                    Container(child: Text("Desconto Máximo: " + snapshot.data[index]["maximoDesconto"].toString()),padding: const EdgeInsets.all(18.0),),
                    Container(child: Text("Preço de Custo: " + snapshot.data[index]["precoCusto"].toString()),padding: const EdgeInsets.all(18.0),),
                    Container(child: Text("Preço de venda: " + snapshot.data[index]["precoVenda"].toString()),padding: const EdgeInsets.all(18.0),),
                  ],
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
