import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/CompletedTaskCard.dart';
import 'package:hire_pro/widgets/NavTop.dart';
import 'package:hire_pro/widgets/UpcomingTaskcard.dart';
import 'package:hire_pro/screens/Job/startJobScreen.dart';
import 'package:hire_pro/screens/Job/biddingRequestScreen.dart';
import 'package:http/http.dart' as http;
import 'package:hire_pro/services/urlCreator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiddingTasks extends StatefulWidget {
  @override
  State<BiddingTasks> createState() => _BiddingTasksState();
}

class _BiddingTasksState extends State<BiddingTasks> {
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarAll(title: 'Bid on Tasks'),
        bottomNavigationBar: BottomNavBar(),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Number of cards
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                    // Navigate to the task details page when card is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BiddingRequest(),
                      ),
                    );
                  },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: UpcomingTaskCard(
                          'Task $index Location',
                          '2023-10-1',
                          'User $index',
                          2500,
                          3500,
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

  Future<void> getTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(jsonDecode(prefs.getString('tokens') ?? '')['accessToken']);
    var response = await http.get(Uri.parse(urlCreate('getBiddingTasks')),
        headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['accessToken']});
    if (response.statusCode == 200) {
      return (jsonDecode(response.body));
    } else {
      if(jsonDecode(response.body)['error'] == 'TokenExpiredError'){
        print(jsonDecode(prefs.getString('tokens') ?? '')['refreshToken']);
        response = await http.get(Uri.parse(urlCreate('refreshToken')),
            headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['refreshToken']});
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['tokens']);
        await prefs.setString('tokens', jsonEncode(jsonResponse['tokens']));
        getTasks();
      }
    }
  }


}



