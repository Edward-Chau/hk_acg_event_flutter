import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/Widget/EventListTileCard.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';
import 'package:hk_acg_event_information/provider/event_list_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendarScreen extends ConsumerStatefulWidget {
  const EventCalendarScreen({super.key});

  @override
  ConsumerState<EventCalendarScreen> createState() =>
      _EventCalendarScreenState();
}

class _EventCalendarScreenState extends ConsumerState<EventCalendarScreen> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  List<String> _selectedEvents = [];

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('活動月曆表'),
        foregroundColor: Colors.white,
        backgroundColor: ETAColors.appbarColors_01,
      ),
      body: events.when(
        data: (eventList) {
          final List<Event> selectedDateOfEvent = eventList.where((event) {
            return _selectedEvents.contains(event.documentId);
          }).toList();

          // EventTime 有 startTime / endTime
          final Map<DateTime, List<String>> eventCalendar = {};

          for (final event in eventList) {
            for (final time in event.eventTimes) {
              final DateTime eventDate = DateTime(
                time.startTime.year,
                time.startTime.month,
                time.startTime.day,
              );

              if (eventCalendar[eventDate] == null) {
                eventCalendar[eventDate] = [];
              }
              eventCalendar[eventDate]!.add(event.documentId);
            }
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime(DateTime.now().year - 10),
                  lastDay: DateTime(DateTime.now().year + 10),
                  eventLoader: (day) {
                    return eventCalendar[
                            DateTime(day.year, day.month, day.day)] ??
                        [];
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _selectedEvents = eventCalendar[DateTime(selectedDay.year,
                              selectedDay.month, selectedDay.day)] ??
                          [];
                    });
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isEmpty) return const SizedBox();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: events.take(3).map((e) {
                          return Container(
                            width: 8, // 小點寬度
                            height: 8, // 小點高度
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle, // 圓形
                              color: Colors.red, // 小點顏色
                            ),
                            // child: Text(events),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                _selectedEvents.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text("當天沒有活動")),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: selectedDateOfEvent.length,
                            itemBuilder: (context, index) {
                              return EventListtilecard(
                                  event: selectedDateOfEvent[index]);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text('共個 ${selectedDateOfEvent.length} 活動'),
                          )
                        ],
                      ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Text('發生錯誤: $err'),
      ),
    );
  }
}
