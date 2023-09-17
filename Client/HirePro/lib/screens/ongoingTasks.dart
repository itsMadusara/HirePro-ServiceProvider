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
              // child: isLoading
              //     ? Center(child: CircularProgressIndicator())
              //     : ListView.builder(
                itemCount: 5, // Number of cards
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        // Navigate to the task details page when card is clicked
                        Navigator.pushNamed(context, '/progress_start');
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: OngoingTaskCard(
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



