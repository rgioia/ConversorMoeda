import 'package:flutter/material.dart';

class Review extends StatelessWidget {

  final String dolar;

  Review({@required this.dolar});

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
          child: Text(dolar)
        )
      )
    );
  }
}
