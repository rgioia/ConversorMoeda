import 'package:flutter/material.dart';
import 'package:conversor_moeda/widgets/moneyMask.dart';

class Review extends StatelessWidget {

  final String dolarPrice;
  final String realPrice;
  final String name;
  final String cellPhone;
  final String emailAddress;

  Review({@required this.name, @required this.cellPhone, @required this.emailAddress, @required this.dolarPrice, @required this.realPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Resumo"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
      padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 25.0),
              child: Image.asset(
                'images/logo_maino.png', height: 100, width: 100
              )
            ),
            Center(
              child: Text(
                  'Obrigado pelo seu contato!',
                  style: TextStyle(color: Colors.black, fontSize: 20.0)
              )
            ),
            Divider(),
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Nome: $name', style: TextStyle(color: Colors.black, fontSize: 17.0)),
                  Divider(),
                  Text('E-mail: $emailAddress', style: TextStyle(color: Colors.black, fontSize: 17.0)),
                  Divider(),
                  Text('Celular: $cellPhone', style: TextStyle(color: Colors.black, fontSize: 17.0)),
                  Divider(),
                  Text('Quantidade de dólares: US\$ $dolarPrice', style: TextStyle(color: Colors.black, fontSize: 17.0)),
                  Divider(),
                  Text('Valores em real: BRL $realPrice', style: TextStyle(color: Colors.black, fontSize: 17.0)),
                ],
              ),
            )
          ]
        ),
      )
    );
  }
}
