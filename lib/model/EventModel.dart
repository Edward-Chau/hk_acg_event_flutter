import 'package:flutter/material.dart';

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

class Event {
  const Event({
    this.id = '',
    this.documentId = '',
    this.title = '沒有標題',
    this.image = const [],
    this.eventTimes = const [],
    // this.ticket = 0.0,
    this.prices = const [],
    this.evenCategory = EvenCategory.other,
    // this.organizer = '',
    this.officialURL = '',
    this.location = '',
    this.eventDetail = '',
  });

  final String id;
  final String documentId;
  final String title;
  final List<String> image;
  final List<DateTime> eventTimes; // 存所有場次的 startTime
  // final double ticket; // 最便宜票價
  final List<String> prices; // 存所有票種價格（字串）
  final EvenCategory evenCategory;
  // final String organizer;
  final String officialURL;
  final String location;
  final String eventDetail;

  factory Event.fromJson(Map<String, dynamic> json) {
    // 轉換 eventTimes -> List<DateTime>（用 startTime）
    final List<DateTime> times = (json['eventTimes'] as List<dynamic>? ?? [])
        .map((e) => DateTime.parse(e['startTime'] as String))
        .toList();

    // tickets -> 最便宜價格 & 所有價格字串
    final tickets = (json['tickets'] as List<dynamic>? ?? []);
    final prices = tickets.map((e) => (e['prices'] as num).toDouble()).toList();
    // final minPrice =
    //     prices.isNotEmpty ? prices.reduce((a, b) => a < b ? a : b) : 0.0;
    final priceStrings = prices.map((p) => p.toString()).toList();
    final List<String> imageList = (json['image'] as List<dynamic>? ?? [])
        .map(
          (e) => 'http://localhost:1337${e['url']}',
        )
        .toList();

    return Event(
      id: json['id']?.toString() ?? '',
      documentId: json['documentId'] ?? '',
      title: json['title'] ?? '沒有標題',
      image: imageList,
      eventTimes: times,
      // ticket: minPrice,
      prices: priceStrings,
      evenCategory: _parseCategory(json['evenCategory']),
      // organizer: json['organizer'] ?? '',
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
        return EvenCategory.other;
      default:
        return EvenCategory.other;
    }
  }
}
