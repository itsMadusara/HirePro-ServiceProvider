import 'package:flutter/material.dart';

class FormFieldRegular extends StatelessWidget {
  FormFieldRegular(this.placeholder, this.controller, this.password,[this.function]);
  final String placeholder;
  final TextEditingController controller;
  final bool password;
  final String? Function(String?)? function;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        validator: function,
        obscureText: password,
        controller: controller,
        cursorColor: Colors.grey[400],
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.red),
          focusedErrorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.only(left: 20),
          enabledBorder: const OutlineInputBorder(
              borderSide:
              BorderSide(color: Color.fromARGB(255, 189, 189, 189))),
          focusedBorder: const OutlineInputBorder(
              borderSide:
              BorderSide(color: Color.fromARGB(255, 136, 136, 136))),
          hintText: placeholder,
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}