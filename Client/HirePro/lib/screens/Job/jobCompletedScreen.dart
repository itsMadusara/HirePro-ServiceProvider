import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/CheckIconLarge.dart';
import 'package:hire_pro/widgets/SmallArrowButton.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';

class JobCompletedScreen extends StatefulWidget {
  const JobCompletedScreen({super.key});

  @override
  State<JobCompletedScreen> createState() => _JobCompletedScreenState();
}

class _JobCompletedScreenState extends State<JobCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomNavBar(),
          appBar: AppBarBackButton(),
            body: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CheckIconLarge(),
                    SizedBox(height: 25),
                    Text(
                      'Job Completed',
                      style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Earn Stars',
                      style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 80),
                  SmallArrowButton(
                      kSecondaryYellow, Icons.arrow_forward, () {Navigator.pushNamed(context, '/earned_ratings');}
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }
}

