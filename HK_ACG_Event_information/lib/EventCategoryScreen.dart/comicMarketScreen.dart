import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/Widget/EventListTileCard.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';

class ComicMarketScreen extends StatefulWidget {
  const ComicMarketScreen(
      {super.key,
      required this.eventList,
      required this.favoriteEventList,
      required this.keep});
  final List<Event> eventList;
  final List<Event> favoriteEventList;
  final Function(Event) keep;
  @override
  State<ComicMarketScreen> createState() => _ComicMarketScreenState();
}

class _ComicMarketScreenState extends State<ComicMarketScreen> {
  @override
  Widget build(BuildContext context) {
    List<Event> filterList = widget.eventList.where((eventItem) {
      return eventItem.evenCategory == EvenCategory.comicMarket;
    }).toList(); //filter

    return Container(
      color: Colors.cyan[50],
      child: ListView.builder(
        itemCount: filterList.length,
        itemBuilder: (context, index) {
          return EventListtilecard(
            event: filterList[index],
            keep: widget.keep,
            favoriteEventList: widget.favoriteEventList,
            eventList: widget.eventList,
          );
        },
      ),
    );
  }
}
