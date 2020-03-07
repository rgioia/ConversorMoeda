import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_masked_text/flutter_masked_text.dart';

const request = "https://api.hgbrasil.com/finance?format=json&key=36468291";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.black,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          hintStyle: TextStyle(color: Colors.black),
        )),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var realController = new MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.');
  var dolarController = new MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.');

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double dolar;
  String _taxApply = '-';

  void _realChanged(String text) {
    double real = realController.numberValue;
    double spred = this.dolar + (this.dolar * 0.015);
    double finalTax = spred + ((20 / (real / this.dolar)) * this.dolar);
    double realBuy = real / finalTax;
    if (real != 0.0) {
      dolarController.updateValue(realBuy);
    } else {
      dolarController.updateValue(0.0);
    }
  }

  void _dolarChanged(String text) {
    double dolar = dolarController.numberValue;
    double spred = this.dolar + (this.dolar * 0.015);
    double finalTax = spred + ((20 / dolar) * this.dolar);
    double dolarBuy = dolar * finalTax;
    if (dolar != 0.0) {
      realController.updateValue(dolarBuy);
    } else {
      realController.updateValue(0.0);
    }
    _taxApply = (dolarBuy / dolar).toStringAsFixed(4);

    setState(() {
      if(_taxApply == 'NaN') {
        _taxApply = '-';
      }
    });
  }

  void _processRequest() {}

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
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      'Erro ao carregar dados :(',
                      style: TextStyle(color: Colors.black, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    if(snapshot.data != null){
                      if(snapshot.data['error'] == true){
                        return Center(
                            child: Text(
                              'Erro ao carregar dados :(',
                              style: TextStyle(color: Colors.black, fontSize: 25.0),
                              textAlign: TextAlign.center,
                            ));
                      } else {
                        dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                      }
                    }
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
                                buildTextField("Reais", realController,
                                    _realChanged, false),
                                Container(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 10.0),
                                  child: Row(children: <Widget>[
                                    Icon(
                                      Icons.info_outline,
                                      size: 20.0,
                                      color: Colors.green,
                                    ),
                                    Text('Taxa utilizada: $_taxApply',
                                        style: TextStyle(fontSize: 15.0))
                                  ]),
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
                                        _processRequest();
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

Widget buildTextField(String label, MoneyMaskedTextController controller,
    Function f, bool isEnabled) {
  return TextFormField(
    controller: controller,
    enabled: isEnabled,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder()),
    style: TextStyle(color: Colors.black, fontSize: 25.0),
    onChanged: f,
    validator: (String value) {
      if (controller.numberValue <= 0.0) {
        return "O valor deve ser maior que 0,00";
      }
      return null;
    },
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}
