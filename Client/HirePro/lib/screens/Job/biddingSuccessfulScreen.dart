import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/CheckIconLarge.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BiddingSuccessfulScreen extends StatefulWidget {
  const BiddingSuccessfulScreen({super.key});

  @override
  State<BiddingSuccessfulScreen> createState() => _BiddingSuccessfulScreenState();
}

class _BiddingSuccessfulScreenState extends State<BiddingSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CheckIconLarge(),
                    SizedBox(height: 25,),
                    Text(
                      'Bidding Successful',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            )));
  }
}
