import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormFieldRegular extends StatelessWidget {
  FormFieldRegular(this.placeholder);
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
      child: TextFormField(
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
