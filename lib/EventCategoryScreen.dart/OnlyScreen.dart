import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/Widget/EventListTileCard.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';

class OnlyScreen extends StatefulWidget {
  const OnlyScreen({super.key, required this.eventList, required this.favoriteEventList, required this.keep});
  final List<Event> eventList;
  final List<Event> favoriteEventList;
  final Function(Event) keep;

  @override
  State<OnlyScreen> createState() => _OnlyScreenState();
}

class _OnlyScreenState extends State<OnlyScreen> {
  @override
  Widget build(BuildContext context) {
    List<Event> filterList = widget.eventList.where((eventItem) {
      return eventItem.evenCategory == EvenCategory.only;
    }).toList(); //filter

    return Container(
      color: Colors.pink[50],
      child: ListView.builder(
        itemCount: filterList.length,
        itemBuilder: (context, index) {
          return EventListtilecard(pushInformationScreen: (){},
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