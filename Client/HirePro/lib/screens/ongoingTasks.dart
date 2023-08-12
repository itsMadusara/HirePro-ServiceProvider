import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/NavTop.dart';
import 'package:hire_pro/widgets/OngoingTaskCard.dart';

class OngoingTasks extends StatefulWidget {
  @override
  State<OngoingTasks> createState() => _OngoingTasksState();
}

class _OngoingTasksState extends State<OngoingTasks> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarAll(title: 'Your Tasks'),
        bottomNavigationBar: BottomNavBar(),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child:
                NavTop(kMainYellow, Colors.white, Colors.white, () {},
                      () {Navigator.pushNamed(context, '/upcoming_tasks');},
                      () {Navigator.pushNamed(context, '/completed_tasks');},
                )
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Number of cards
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: OngoingTaskCard(
                      'Task $index Location',
                      '2023-10-1',
                      '2:30',
                      'Sachini Muthugala',
                      2500,
                      4.5,
                      'images/task1.png',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



