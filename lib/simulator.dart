import 'package:flutter/material.dart';
import 'package:conversor_moeda/review.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:conversor_moeda/moneyMask.dart';

const request = "https://api.hgbrasil.com/finance?format=json&key=98a674d77";

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Simulator extends StatefulWidget {
  final String name;
  final String cellPhone;
  final String emailAddress;

  Simulator({@required this.name, @required this.cellPhone, @required this.emailAddress});

  @override

  _SimulatorState createState() => _SimulatorState(name: this.name, cellPhone: this.cellPhone, emailAddress: this.emailAddress);
}

class _SimulatorState extends State<Simulator> {
  final String name;
  final String cellPhone;
  final String emailAddress;

  double dolar;
  String dolarPrice;
  String realPrice;

  _SimulatorState({@required this.name, @required this.cellPhone, @required this.emailAddress});

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var realController = new MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.');
  var dolarController = new MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.');
  var taxApplyController = new MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', precision: 4);

  void _dolarChanged(String text) {
    double dolar = dolarController.numberValue;
    double spred = this.dolar + (this.dolar * 0.015);
    double finalTax = spred + ((20 / dolar) * this.dolar);
    double dolarBuy = dolar * finalTax;
    if (dolar != 0.0) {
      realController.updateValue(dolarBuy);
      taxApplyController.updateValue(dolarBuy / dolar);
    } else {
      realController.updateValue(0.0);
      taxApplyController.updateValue(0.0);
    }

    realPrice  = dolarBuy.toStringAsFixed(2);
    dolarPrice = dolar.toStringAsFixed(2);
  }

  void _processRequest(context, name, cellPhone, emailAddress, dolarPrice, realPrice) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Review(
        name: name, cellPhone: cellPhone, emailAddress: emailAddress, dolarPrice: dolarPrice, realPrice: realPrice
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Câmbio Mainô"),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text(
                    'Carregando dados...',
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      'Erro ao carregar dados :(',
                      style: TextStyle(color: Colors.black, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    dolar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];

                    return SingleChildScrollView(
                        padding: EdgeInsets.all(10.0),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.fromLTRB(
                                        15.0, 15.0, 15.0, 25.0),
                                    child: Image.asset(
                                      'images/logo_maino.png',
                                      height: 100,
                                      width: 100,
                                    )),
                                buildTextField('Dólares', dolarController,
                                    _dolarChanged, true),
                                Divider(),
                                buildTextField(
                                    "Reais", realController, null, false),
                                Column(
                                  children: <Widget>[
                                    Container(
                                        height: 40.0,
                                        child: TextField(
                                          controller: taxApplyController,
                                          enabled: false,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefix: Text('Taxa utilizada: '),
                                          ),
                                        )),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 8.0),
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: Colors.green,
                                    child: Text('Solicitar contato',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white)),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _processRequest(context, name, cellPhone, emailAddress, dolarPrice, realPrice);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )));
                  }
              }
            }));
  }
}
