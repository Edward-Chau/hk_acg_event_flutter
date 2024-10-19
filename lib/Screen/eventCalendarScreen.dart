import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({super.key});

  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('活動月曆表'),
        foregroundColor: Colors.white,
        backgroundColor: ETAColors.appbarColors_01,
      ),
      body: TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime(DateTime.now().year - 10),
          lastDay: DateTime(DateTime.now().year + 10)),
    );
  }
}
