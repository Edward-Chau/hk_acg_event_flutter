import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/EventCategoryScreen.dart/ACGCategoryScreen.dart';
import 'package:hk_acg_event_information/EventCategoryScreen.dart/allCategory.dart';
import 'package:hk_acg_event_information/EventCategoryScreen.dart/comicMarketScreen.dart';
import 'package:hk_acg_event_information/EventCategoryScreen.dart/electronicMusicScreen.dart';
import 'package:hk_acg_event_information/EventCategoryScreen.dart/onlyScreen.dart';
import 'package:hk_acg_event_information/Screen/favouriteScreen.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';

class Eventscreen extends StatefulWidget {
  const Eventscreen(
      {required this.eventList,
      super.key,
      required this.keep,
      required this.favoriteEvent});
  final List<Event> eventList;
  final Function(Event) keep;
  final List<Event> favoriteEvent;
  @override
  State<Eventscreen> createState() => _EventscreenState();
}

class _EventscreenState extends State<Eventscreen> {
  List<Event>? filterList;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: EvenCategory.values.length + 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('活動消息'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return FavouriteScreen(
                        favoriteEvent: widget.favoriteEvent,
                        keep: widget.keep,
                        eventList: widget.eventList,
                      );
                    },
                  ),
                );
              }, //OpenFavouriteScreen
              icon: const Icon(
                Icons.event_available,
                color: Colors.white,
              ),
            )
          ],
          backgroundColor: ETAColors.appbarColors_01,
          bottom: const TabBar(
            labelColor: Colors.white,
            // isScrollable: true,
            tabs: [
              Tab(text: '全部'), //1
              Tab(text: '動漫展'), //2
              Tab(text: '同人展'), //3
              Tab(text: 'only場'), //4
              Tab(text: '動漫電音節'), //5
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Allcategory(
              eventList: widget.eventList,
              keep: widget.keep,
              favoriteEventList: widget.favoriteEvent,
            ), //1
            ACGCategoryScreen(
              eventList: widget.eventList,
              keep: widget.keep,
              favoriteEventList: widget.favoriteEvent,
            ), //2
            ComicMarketScreen(
              eventList: widget.eventList,
              keep: widget.keep,
              favoriteEventList: widget.favoriteEvent,
            ),
            OnlyScreen(
              eventList: widget.eventList,
              keep: widget.keep,
              favoriteEventList: widget.favoriteEvent,
            ),
            ElectronicmusicScreen(
              eventList: widget.eventList,
              keep: widget.keep,
              favoriteEventList: widget.favoriteEvent,
            ),
          ],
        ),
      ),
    );
  }
}
