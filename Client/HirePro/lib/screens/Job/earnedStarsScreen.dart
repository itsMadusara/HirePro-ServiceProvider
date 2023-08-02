import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/StarRatingBar.dart';
import 'package:hire_pro/widgets/SmallArrowButton.dart';

class EarnedStarsScreen extends StatefulWidget {
  const EarnedStarsScreen({super.key});

  @override
  State<EarnedStarsScreen> createState() => _EarnedStarsScreenState();
}

class _EarnedStarsScreenState extends State<EarnedStarsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomNavBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                              'Good Job !',
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        const Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Congratulations',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),

                              ),
                              Text(
                                "You've Earned",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),

                        ),

                        Expanded(
                          flex: 1,
                          child: StarRatingBar(rating: 3.4,ratingCount: 12,),
                        ),

                        const Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "You've been given a tip!",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),

                              ),
                              Text(
                                "Rs:500",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),

                        ),

                        Expanded(
                          flex: 1,
                          child: SmallArrowButton(
                              kSecondaryYellow, Icons.arrow_forward, () {})
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
