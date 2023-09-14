import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/services/calander.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/CompletedTaskCard.dart';
import 'package:hire_pro/widgets/NavTop.dart';
import 'package:hire_pro/widgets/UpcomingTaskcard.dart';

class ViewCalendarScreen extends StatefulWidget {
  @override
  State<ViewCalendarScreen> createState() => _ViewCalendarScreenState();
}

class _ViewCalendarScreenState extends State<ViewCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarAll(title: 'Your Tasks'),
        bottomNavigationBar: BottomNavBar(),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Column(
              children: [
                Calander()
              ],
            ),
          )

      ),
    );
  }
}