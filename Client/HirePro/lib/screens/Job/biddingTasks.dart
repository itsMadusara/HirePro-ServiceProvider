import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/BiddingTasksCard.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/CompletedTaskCard.dart';
import 'package:hire_pro/widgets/NavTop.dart';
import 'package:hire_pro/widgets/UpcomingTaskcard.dart';
import 'package:hire_pro/screens/Job/startJobScreen.dart';
import 'package:hire_pro/screens/Job/biddingRequestScreen.dart';
import 'package:http/http.dart' as http;
import 'package:hire_pro/services/urlCreator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../widgets/NavTopBid.dart';

class BiddingTasks extends StatefulWidget {
  @override
  State<BiddingTasks> createState() => _BiddingTasksState();
}

class _BiddingTasksState extends State<BiddingTasks> {
  List<dynamic> tasks = [];
  bool isLoading = true;

  void initState() {
    super.initState();
    _loadUserData();
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
            Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child:
                NavTopBid(kMainYellow,Colors.white, () {},
                      () {Navigator.pushNamed(context, '/bidding_done_tasks');},
                )
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: tasks.length, // Number of cards
                      itemBuilder: (context, index) {
                        String minEst = tasks[index]['serviceValue']['estmin'].toString();
                        String maxEst = tasks[index]['serviceValue']['estmax'].toString();
                        return GestureDetector(
                            onTap: () {
                          // Navigate to the task details page when card is clicked
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BiddingRequest(taskDescription: tasks[index]),
                            ),
                          );
                        },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              child: BiddingTaskCard(
                                tasks[index]['serviceValue']['location'],
                                toDate(tasks[index]['serviceValue']['posted_timestamp']),
                                tasks[index]['serviceValue']['description'],
                                double.parse(minEst),
                                double.parse(maxEst),
                                2,
                                tasks[index]['serviceValue']['id'].toString(),
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

  Future<String> fetchTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(urlCreate('getBiddingTasks')),
        headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['accessToken']});
    if (response.statusCode == 200) {
      return (response.body);
    } else {
      if(jsonDecode(response.body)['error'] == 'TokenExpiredError'){
        response = await http.get(Uri.parse(urlCreate('refreshToken')),
            headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['refreshToken']});
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['tokens']);
        await prefs.setString('tokens', jsonEncode(jsonResponse['tokens']));
        fetchTasks();
      }
      throw Exception('Failed to load album');
    }
  }

  Future<void> _loadUserData() async {
    try {
      final userData = await fetchTasks();
      List<dynamic> userDataMap = jsonDecode(userData);
      // userDataMap.forEach((element) {print(element);});
      setState(() {
        tasks = userDataMap;
        isLoading = false; // Set isLoading to false after data is loaded
      });
      print(userDataMap);
      return;
    } catch (error) {
      print('Error fetching user data: $error');
      setState(() {
        tasks = [];
        isLoading = false; // Set isLoading to false after data is loaded
      });
      return;
    }
  }

  String toDate(String utcTimestamp) {
    DateTime dateTime = DateTime.parse(utcTimestamp);
    String formattedDateTime = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDateTime; // This will print: 2023-08-14 06:00:00
  }


}



