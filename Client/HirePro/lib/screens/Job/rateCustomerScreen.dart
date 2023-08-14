import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/CheckIconLarge.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_pro/widgets/SmallArrowButton.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';

class RateCustomerScreen extends StatefulWidget {
  const RateCustomerScreen({super.key});

  @override
  State<RateCustomerScreen> createState() => _RateCustomerScreenState();
}

class _RateCustomerScreenState extends State<RateCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBarBackButton(),
            bottomNavigationBar: BottomNavBar(),
            body: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CheckIconLarge(),
                    SizedBox(height: 25,),
                    Text(
                      'Job Completed',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 100,),
                    Text('Rate Your Customer',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    SizedBox(height: 15,),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(height: 80),
                    SmallArrowButton(
                        kSecondaryYellow, Icons.arrow_forward, () {Navigator.pushNamed(context, '/view_rated');}
                    ),
                  ],
                ),
              ),
            )));
  }
}
