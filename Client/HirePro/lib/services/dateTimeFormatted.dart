import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormatted extends StatelessWidget {
  final DateTime dateTime;

  DateTimeFormatted(this.dateTime);

  @override
  Widget build(BuildContext context) {
    // Format DateTime as "June 22, 2023"
    String formattedDateTime = DateFormat('MMMM dd, yyyy').format(dateTime);

    return Text(
      formattedDateTime,
      style: TextStyle(fontSize: 12),
    );
  }
}
