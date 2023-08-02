import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  MainButton(this.buttonText, this.navigation);
 final String buttonText;
 final VoidCallback navigation;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 220,
      child: RawMaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.5)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        elevation: 0,
        highlightElevation: 0,
        highlightColor: Color.fromARGB(255, 253, 171, 77),
        
        onPressed: navigation,
        fillColor: Color(0xFFD4842B),
        child: Text(buttonText,
            style:const  TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
