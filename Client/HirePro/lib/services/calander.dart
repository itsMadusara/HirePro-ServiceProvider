import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class Calander extends StatefulWidget {
  @override
  _CalanderState createState() => _CalanderState();
}

class _CalanderState extends State<Calander> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: TableCalendar(
        calendarStyle: CalendarStyle(
            markerDecoration: BoxDecoration(color: kMainYellow),
            todayDecoration: BoxDecoration(color: kMainYellow)),
        firstDay: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDay: DateTime(
            DateTime.now().year, DateTime.now().month + 1, DateTime.now().day),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
       
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
