import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/StarRatingIndicator.dart';
import 'package:hire_pro/widgets/SmallArrowButton.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';

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
          appBar: AppBarBackButton(),
          bottomNavigationBar: BottomNavBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Good Job !',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
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
                              ),
                              SizedBox(height: 20,),
                              StarRatingIndicator(4, 30,Colors.amber)
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              ),
                              Container(
                                  height: 50,
                                  child: SmallArrowButton(
                                      kSecondaryYellow, Icons.arrow_forward, () {Navigator.pushNamed(context, '/rate_customer');})
                              ),
                            ],
                          ),

                        ),



                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
