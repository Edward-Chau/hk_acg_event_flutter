import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/Widget/EventListTileCard.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';

class Allcategory extends StatefulWidget {
  const Allcategory(
      {required this.eventList,
      super.key,
      required this.keep,
      required this.favoriteEventList});
  final List<Event> eventList;
  final List<Event> favoriteEventList;
  final Function(Event) keep;
  @override
  State<Allcategory> createState() => _AllcategoryState();
}

class _AllcategoryState extends State<Allcategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ETAColors.screenBackgroundColor,
      child: Scrollbar(
        child: ListView.builder(
          itemCount: widget.eventList.length,
          itemBuilder: (context, index) {
            return EventListtilecard(
              event: widget.eventList[index],
              favoriteEventList: widget.favoriteEventList,
              keep: widget.keep,
              eventList: widget.eventList,
            );
          },
        ),
      ),
    );
  }
}
