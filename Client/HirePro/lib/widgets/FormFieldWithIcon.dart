import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormFieldWithIcon extends StatelessWidget {
  FormFieldWithIcon(this.placeholder);
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        cursorColor: Colors.grey[400],
        decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: EdgeInsets.only(left: 20),
          prefixIcon: const Padding(
            padding: EdgeInsets.fromLTRB(10, 12, 100, 0),
            child: FaIcon(
              FontAwesomeIcons.google,
              color: Colors.grey,
            ),
          ),
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
