import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/CompletedTaskCard.dart';
import 'package:hire_pro/widgets/NavTop.dart';
import 'package:hire_pro/widgets/UpcomingTaskcard.dart';

class UpcomingTasks extends StatefulWidget {
  @override
  State<UpcomingTasks> createState() => _UpcomingTasksState();
}

class _UpcomingTasksState extends State<UpcomingTasks> {
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
                NavTop(Colors.white, kMainYellow,Colors.white,
                        () {Navigator.pushNamed(context, '/ongoing_tasks');},
                        () {},
                        () {Navigator.pushNamed(context, '/completed_tasks');})
            ),
            Expanded(
              child: ListView.builder(
                // child: isLoading
                //     ? Center(child: CircularProgressIndicator())
                //     : ListView.builder(
                itemCount: 1, // Number of cards
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        // Navigate to the task details page when card is clicked
                        Navigator.pushNamed(context, '/start_job');
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: UpcomingTaskCard(
                          'Vijitha MW, Nagoda',
                          '2023-8-17',
                          '2:30',
                          'Tharushi Silva',
                          2500,
                          4.5,
                          'images/task1.png',
                        ),
                      )
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



