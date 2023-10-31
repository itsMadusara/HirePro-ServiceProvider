import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hire_pro/services/urlCreator.dart';
import 'package:hire_pro/widgets/UpcomingTaskcard.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class Calander extends StatefulWidget {
  const Calander({Key? key}) : super(key: key);

  @override
  _CalanderState createState() => _CalanderState();
}

class _CalanderState extends State<Calander> {
  List<dynamic> tasks = [];
  bool isLoading = true;
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<dynamic>> _events = {};

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


  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<String> fetchTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(urlCreate('getAllTasks')),
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
        isLoading = false;// Set isLoading to false after data is loaded
        for(var i in tasks){
          DateTime dateTime = DateTime.parse(i['time']);
          String formattedDateTime = DateFormat('yyyy-MM-dd 00:00:00.000').format(dateTime);
          dateTime = DateTime.parse(formattedDateTime);
          Map<String, dynamic> temp = i['serviceValue'];
          temp['customerName'] = i['customerName'];
          temp['amount'] = i['bidValues']['amount'];
          if(_events[dateTime]!= null){
            _events[dateTime]?.add(temp);
          } else{
            _events[dateTime] = [temp];
          }
        }
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

  List _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  Widget _buildDay(BuildContext context, DateTime day) {
    final events = _getEventsForDay(day);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDay = day;
        });
      },
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          :Container(
            decoration: BoxDecoration(
              color: _selectedDay == day ? Colors.blue : null,
              shape: BoxShape.circle,
            ),
            child: Column(
              children: [
                Text(
                  day.day.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: _selectedDay == day ? Colors.white : Colors.black,
                  ),
                ),
                if (events.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < events.length; i++)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _selectedDay == day ? Colors.white : Colors.blue,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    print(_events);
    return Container(
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
            children: [
              Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    TableCalendar(
                      firstDay: DateTime.now().subtract(Duration(days: 365)),
                      lastDay: DateTime.now().add(Duration(days: 365)),
                      focusedDay: _selectedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) => _buildDay(context, day),
                      ),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (_selectedDay != null)
                Container(
                  margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Column(
                    children: _getEventsForDay(_selectedDay).map((event) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10.0), // Add margin between UpcomingTaskCards
                        child: UpcomingTaskCard(
                          event['location'],
                          toDate(event['date']),
                          toTime(event['date']),
                          event['customerName'].toString(),
                          event['amount'].toDouble(),
                          4.5,
                          'images/task1.png',
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}