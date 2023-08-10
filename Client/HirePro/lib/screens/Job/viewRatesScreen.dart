import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/CheckIconLarge.dart';
import 'package:hire_pro/widgets/StarRatingIndicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_pro/widgets/SmallArrowButton.dart';

class ViewRatedScreen extends StatefulWidget {
  const ViewRatedScreen({super.key});

  @override
  State<ViewRatedScreen> createState() => _ViewRatedScreenState();
}

class _ViewRatedScreenState extends State<ViewRatedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Thank You',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 80,),
                    Image.asset('images/hireProWithoutBG.png'),
                    Text(
                      'You have given stars to your customer',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 15,),
                    StarRatingIndicator(3, 40),

                    SizedBox(height: 80),
                  ],
                ),
              ),
            )
        )
    );
  }
}
