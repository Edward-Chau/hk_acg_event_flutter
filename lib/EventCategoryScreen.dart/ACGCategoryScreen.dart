import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/Widget/EventListTileCard.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';

class ACGCategoryScreen extends StatefulWidget {
  const ACGCategoryScreen(
      {super.key,
      required this.eventList,
      required this.favoriteEventList,
      required this.keep, required this.pushInformationScreen});
  final List<Event> eventList;
  final List<Event> favoriteEventList;
  final Function() pushInformationScreen;
  final Function(Event) keep;

  @override
  State<ACGCategoryScreen> createState() => _ACGCategoryScreenState();
}

class _ACGCategoryScreenState extends State<ACGCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    List<Event> filterList = widget.eventList.where((eventItem) {
      return eventItem.evenCategory == EvenCategory.acg;
    }).toList(); //filter

    return Container(
      color: Colors.amber[50],
      child: ListView.builder(
        itemCount: filterList.length,
        itemBuilder: (context, index) {
          return EventListtilecard(pushInformationScreen: widget.pushInformationScreen,
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
