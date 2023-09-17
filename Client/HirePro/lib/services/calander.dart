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
  Map<DateTime, List<String>> _events = {
    DateTime(DateTime.now().year, DateTime.now().month, 5): ['Event 1', 'Event 2'],
    DateTime(DateTime.now().year, DateTime.now().month, 13): ['Event 3'],
    DateTime(DateTime.now().year, DateTime.now().month, 23): ['Event 4'],
    DateTime(DateTime.now().year, DateTime.now().month+1, 25): ['Event 4'],
  };

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
          String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(dateTime);
          dateTime = DateTime.parse(formattedDateTime);
          _events[dateTime] = ['Event 1', 'Event 2'];
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

  List<String> _getEventsForDay(DateTime day) {
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
                          'Gemunu Mawatha, Dehiwala',
                          '2023-10-1',
                          '10:15',
                          'T.Madusara',
                          3500,
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