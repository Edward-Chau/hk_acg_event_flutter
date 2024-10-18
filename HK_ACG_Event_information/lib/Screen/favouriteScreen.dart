import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/Widget/EventListTileCard.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen(
      {required this.favoriteEvent,
      super.key,
      required this.keep,
      required this.eventList});
  final List<Event> eventList;
  final List<Event> favoriteEvent;
  final Function(Event) keep;
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ETAColors.screenBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData().copyWith(color: Colors.white),
        title: const Text(
          '標記的活動',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: ETAColors.appbarColors_01,
      ),
      body: widget.favoriteEvent.isEmpty
          ? const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "沒有標記任何的活動",
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : Expanded(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.favoriteEvent.length,
                    itemBuilder: (context, index) {
                      return EventListtilecard(
                        event: widget.favoriteEvent[index],
                        favoriteEventList: widget.favoriteEvent,
                        keep: widget.keep,
                        eventList: widget.eventList,
                      );
                    },
                  ),
                  Text('共有 ${widget.favoriteEvent.length} 項收藏'),
                ],
              ),
            ),
    );
  }
}
