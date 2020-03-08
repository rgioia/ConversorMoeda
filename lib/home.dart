import 'package:flutter/material.dart';
import 'package:conversor_moeda/simulator.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:email_validator/email_validator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var cellphoneController    = new MaskedTextController(mask: '(00) 0 0000-0000');
  var nameController         = new TextEditingController();
  var emailAddressController = new TextEditingController();

  String name;
  String emailAddress;
  String cellPhone;

  void _nameChanged(String text){
    name = text;
  }

  void _cellPhoneChanged(String text){
    cellPhone = text;
  }

  void _emailAddressChanged(String text){
    emailAddress = text;
  }

  void _processToSimulation(context, name, cellPhone, emailAddress) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Simulator(name: name, cellPhone: cellPhone, emailAddress: emailAddress ))
    );
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
        body: SingleChildScrollView(
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
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: 'Nome',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder()),
                      style: TextStyle(color: Colors.black, fontSize: 25.0),
                      onChanged: _nameChanged,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Este campo não pode ficar em branco";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    Divider(),
                    TextFormField(
                        controller: emailAddressController,
                        decoration: InputDecoration(
                            labelText: 'E-mail',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder()),
                        style: TextStyle(color: Colors.black, fontSize: 25.0),
                        onChanged: _emailAddressChanged,
                        validator: (String value) {
                          if (value.isEmpty || !EmailValidator.validate(value)) {
                            return value.isEmpty ? "Este campo não pode ficar em branco" : "O e-mail deve ser válido";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress
                    ),
                    Divider(),
                    TextFormField(
                        controller: cellphoneController,
                        decoration: InputDecoration(
                            hintText: '(xx) x xxxx-xxxx',
                            labelText: 'Celular',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder()),
                        style: TextStyle(color: Colors.black, fontSize: 25.0),
                      onChanged: _cellPhoneChanged,
                        validator: (String value) {
                          if (value.isEmpty || value.length < 16) {
                            return value.isEmpty ? "Este campo não pode ficar em branco" : "O celular deve ser válido";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8.0),
                      height: 50.0,
                      child: RaisedButton(
                        color: Colors.green,
                        child: Text('Prosseguir para simulação',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _processToSimulation(context, name, emailAddress, cellPhone);
                          }
                        },
                      ),
                    ),
                  ],
                ))));
  }
}
