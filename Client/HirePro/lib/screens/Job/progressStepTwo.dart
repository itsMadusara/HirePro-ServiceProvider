import 'dart:convert';
import 'package:flutter/material.dart';

class ProgressStepTwo extends StatefulWidget {
  @override
  State<ProgressStepTwo> createState() => _ProgressStepTwoState();
}

String jsondata =
    '{"full_name": "John Doe", "email": "sachinimuthugala@gmail.com", "phone_number": "123-456-7890"}';
var userData = jsonDecode(jsondata);

class _ProgressStepTwoState extends State<ProgressStepTwo> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Image.asset('images/work_in_progress.gif'),
          ],
        ),
      ),

    );
  }
}




