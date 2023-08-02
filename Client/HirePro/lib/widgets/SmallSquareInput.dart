import 'package:flutter/material.dart';

class SmallSquareInput extends StatelessWidget {
  const SmallSquareInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        color: Color(0XFFEEEE),
        height: 50,
        width: 50,
        child: TextFormField(
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 136, 136, 136))),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          cursorColor: Colors.grey,
        ));
  }
}
