import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/NavTop.dart';
import 'package:hire_pro/widgets/OngoingTaskCard.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../services/urlCreator.dart';
import 'Job/progress.dart';

class OngoingTasks extends StatefulWidget {
  @override
  State<OngoingTasks> createState() => _OngoingTasksState();
}

class _OngoingTasksState extends State<OngoingTasks> {
  List<dynamic> tasks = [];
  bool isLoading = true;

  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<String> fetchTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(urlCreate('getOngoingTasks')),
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

  String toTime(String utcTimestamp) {
    DateTime dateTime = DateTime.parse(utcTimestamp);
    String formattedDateTime = DateFormat('HH:mm').format(dateTime);
    return formattedDateTime; // This will print: 2023-08-14 06:00:00
  }

  double progress(String status) {
    if(status == 'Started') {
      return 0.10;
    } else if (status == 'Arrived') {
      return 0.30;
    } else {
      return 0.0;
    }
  }

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
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                    itemCount: tasks.length, // Number of cards
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            // Navigate to the task details page when card is clicked
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProgressStart(taskDescription: tasks[index]),
                              )
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: OngoingTaskCard(
                              tasks[index]['serviceValue']['location'],
                              toDate(tasks[index]['serviceValue']['posted_timestamp']),
                              toTime(tasks[index]['serviceValue']['posted_timestamp']),
                              tasks[index]['customerName'],
                              tasks[index]['bidValues']['amount'].toDouble(),
                              4.5,
                              'images/task1.png',
                              progress(tasks[index]['serviceValue']['status']),
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



