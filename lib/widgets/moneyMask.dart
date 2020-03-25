import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

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
      if (controller.numberValue < 100.0) {
        return "O valor deve ser a partir de 100,00";
      }
      return null;
    },
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}