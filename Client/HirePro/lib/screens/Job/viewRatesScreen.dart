import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/StarRatingIndicator.dart';

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
            appBar: AppBarBackButton(),
            bottomNavigationBar: BottomNavBar(),
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
                    StarRatingIndicator(3, 40, Colors.amber),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            )
        )
    );
  }
}
