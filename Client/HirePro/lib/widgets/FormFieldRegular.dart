import 'package:flutter/material.dart';

class FormFieldRegular extends StatelessWidget {
  FormFieldRegular(this.placeholder, this.controller, this.password);
  final String placeholder;
  final TextEditingController controller;
  final bool password;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        obscureText: password,
        controller: controller,
        cursorColor: Colors.grey[400],
        decoration: InputDecoration(
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