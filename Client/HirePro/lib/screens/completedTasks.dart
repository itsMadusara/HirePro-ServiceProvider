import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/CompletedTaskCard.dart';
import 'package:hire_pro/widgets/NavTop.dart';

class CompletedTasks extends StatefulWidget {
  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
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
              child: NavTop(
                Colors.white,
                Colors.white,
                kMainYellow,
                    () {
                  Navigator.pushNamed(context, '/ongoing_tasks');
                },
                    () {
                  Navigator.pushNamed(context, '/upcoming_tasks');
                },
                    () {},
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Number of cards
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: CompletedTaskCard(
                      'Task $index Location',
                      '2023-10-1',
                      'User $index',
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