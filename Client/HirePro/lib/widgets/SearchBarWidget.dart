import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Material(
        elevation: 1,
        shadowColor: Colors.grey[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: TextField(
          cursorColor: Colors.grey[600],
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: 30,
                color: Colors.black,
              ),
              hintText: 'Find Tasks',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 226, 226, 226))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 226, 226, 226)))),
        ),
      ),
    );
  }
}
