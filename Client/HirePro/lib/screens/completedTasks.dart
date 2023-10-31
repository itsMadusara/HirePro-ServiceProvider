import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/CompletedTaskCard.dart';
import 'package:hire_pro/widgets/NavTop.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../services/urlCreator.dart';

class CompletedTasks extends StatefulWidget {
  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  List<dynamic> tasks = [];
  bool isLoading = true;

  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<String> fetchTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(urlCreate('getCompleted')),
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
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  :ListView.builder(
                    itemCount: tasks.length, // Number of cards
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: CompletedTaskCard(
                          tasks[index]['serviceValue']['location'],
                          toDate(tasks[index]['serviceValue']['posted_timestamp']),
                          tasks[index]['customerName'],
                          tasks[index]['bidValues']['amount'].toDouble(),
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