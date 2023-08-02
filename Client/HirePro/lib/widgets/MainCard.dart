import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  MainCard(this.height, this.width, this.color, this.child);
  final double height;
  final double width;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),

        color: color,
        elevation: 3,
        child: child,
      ),
    );
  }
}
