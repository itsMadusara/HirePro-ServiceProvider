import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/UpcomingTaskcard.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class Calander extends StatefulWidget {
  const Calander({Key? key}) : super(key: key);

  @override
  _CalanderState createState() => _CalanderState();
}

class _CalanderState extends State<Calander> {
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<String>> _events = {
    DateTime(DateTime.now().year, DateTime.now().month, 5): ['Event 1', 'Event 2'],
    DateTime(DateTime.now().year, DateTime.now().month, 13): ['Event 3'],
    DateTime(DateTime.now().year, DateTime.now().month, 23): ['Event 4'],
  };

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
      child: Container(
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
    return Container(
      child: Column(
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