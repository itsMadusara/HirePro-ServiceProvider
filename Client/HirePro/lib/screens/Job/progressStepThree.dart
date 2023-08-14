import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/UploadImageBox.dart';
import 'package:flutter/services.dart';



class ProgressStepThree extends StatefulWidget {
  @override
  State<ProgressStepThree> createState() => _ProgressStepThreeState();
}

String jsondata =
    '{"full_name": "John Doe", "email": "sachinimuthugala@gmail.com", "phone_number": "123-456-7890"}';
var userData = jsonDecode(jsondata);

class _ProgressStepThreeState extends State<ProgressStepThree> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Text('Upload an Image as a proof of work completed.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,),
            SizedBox(height: 20,),
            UploadImageBox('Upload Here'),
          ],
        ),
      ),

    );
  }
}




