import 'package:flutter/material.dart';

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
      body: Container(
        child: Center(
          child: Text("$name $dolarPrice $realPrice $cellPhone $emailAddress")
        )
      )
    );
  }
}
