import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';

class UploadImageBox extends StatelessWidget {
  UploadImageBox(this.placeholder);
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 330,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.cloud_upload_outlined,size: 40,),
              color: Colors.grey,
              onPressed: () {
                // Add your onPressed logic here
              },
            ),
            Text(placeholder, style: TextStyle(color: Colors.grey),),
          ],
        ),
      ),
    );
  }
}