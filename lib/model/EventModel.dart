import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum EvenCategory { acg, comicMarket, only, electronicMusic, other }

var evenCategoryChineseName = {
  EvenCategory.acg: "動漫展",
  EvenCategory.comicMarket: "同人展",
  EvenCategory.only: "only場",
  EvenCategory.electronicMusic: "動漫電音節",
  EvenCategory.other: "其他"
};

var evenCategoryColor = {
  EvenCategory.acg: Colors.orange[300],
  EvenCategory.comicMarket: Colors.blue[700],
  EvenCategory.only: Colors.green[300],
  EvenCategory.electronicMusic: Colors.purple[300],
  EvenCategory.other: Colors.grey[300]
};

// ------------------ EventTime ------------------
class EventTime {
  final DateTime startTime;
  final DateTime endTime;

  EventTime({required this.startTime, required this.endTime});

  factory EventTime.fromJson(Map<String, dynamic> json) {
    final date = json['event_Date'] as String? ?? '';
    final startTimeStr = json['start_Time'] as String? ?? '00:00:00.000';
    final endTimeStr = json['end_Time'] as String? ?? '23:59:59.999';

    // 合併成完整時間字串
    final startDateTime = DateTime.parse('$date $startTimeStr');
    final endDateTime = DateTime.parse('$date $endTimeStr');

    return EventTime(
      startTime: startDateTime,
      endTime: endDateTime,
    );
  }

//   String formatDateWithWeekday(DateTime date) {
//   final weekdays = ['日', '一', '二', '三', '四', '五', '六'];
//   return '${DateFormat('dd/MM/yyyy').format(date)}(${weekdays[date.weekday % 7]})';
// }

  /// 格式化成 yyyy/MM/dd(周) HH:mm ~ HH:mm
  String formatDetailTime() {
    final weekdays = ['日', '一', '二', '三', '四', '五', '六'];
    final startWeek = weekdays[startTime.weekday % 7]; // Dart 週日=7
    final startDate = DateFormat('yyyy/MM/dd').format(startTime);
    final startTimeStr = DateFormat('HH:mm').format(startTime);
    final endTimeStr = DateFormat('HH:mm').format(endTime);
    return '$startDate($startWeek) $startTimeStr ~ $endTimeStr';
  }
}

class Ticket {
  final String category;
  final double price;

  Ticket({required this.category, required this.price});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      category: json['TicketCategory'] ?? '',
      price: (json['prices'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

// ------------------ Event ------------------
class Event {
  const Event({
    this.id = '',
    this.documentId = '',
    this.title = '沒有標題',
    this.image = const [],
    this.eventTimes = const [],
    this.tickets = const [],
    this.evenCategory = EvenCategory.other,
    this.organizer = '',
    this.officialURL = '',
    this.location = '',
    this.eventDetail = '',
  });

  final String id;
  final String documentId;
  final String title;
  final List<String> image;
  final List<EventTime> eventTimes;
  final List<Ticket> tickets;
  final EvenCategory evenCategory;
  final String organizer;
  final String officialURL;
  final String location;
  final String eventDetail;

  factory Event.fromJson(Map<String, dynamic> json) {
    // eventTimes -> List<EventTime>
    final List<EventTime> times = (json['eventTimes'] as List<dynamic>? ?? [])
        .map((e) => EventTime.fromJson(e))
        .toList();

    final ticketList = (json['tickets'] as List<dynamic>? ?? [])
        .map((e) => Ticket.fromJson(e))
        .toList();

    final List<String> imageList = (json['image'] as List<dynamic>? ?? [])
        .map((e) => 'http://localhost:1337${e['url']}')
        .toList();

    return Event(
      id: json['id']?.toString() ?? '',
      documentId: json['documentId'] ?? '',
      title: json['title'] ?? '沒有標題',
      image: imageList,
      eventTimes: times,
      tickets: ticketList,
      evenCategory: _parseCategory(json['evenCategory']),
      organizer:
          json['organizer'] != null ? json['organizer']['organizer_name'] : '',
      officialURL: json['officialURL'] ?? '',
      location: json['location'] ?? '',
      eventDetail: json['eventDetail'] ?? '',
    );
  }

  static EvenCategory _parseCategory(String? cat) {
    switch (cat) {
      case 'acg':
        return EvenCategory.acg;
      case 'comicMarket':
        return EvenCategory.comicMarket;
      case 'only':
        return EvenCategory.only;
      case 'electronicMusic':
        return EvenCategory.electronicMusic;
      case 'other':
      default:
        return EvenCategory.other;
    }
  }
}
