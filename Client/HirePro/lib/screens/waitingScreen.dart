import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Waiting for Verification...",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              LoadingAnimationWidget.prograssiveDots(
                color: kMainYellow,
                size: 100,
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Image.asset(
                  'images/handyman.jpg',
                  height: 450,
                ),
              )
            ],
          ),
      ),
    ),
    );
  }
}



