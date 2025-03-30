import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/EventCategoryScreen.dart/ACGCategoryScreen.dart';
import 'package:hk_acg_event_information/EventCategoryScreen.dart/allCategory.dart';
import 'package:hk_acg_event_information/Screen/eventCalendarScreen.dart';
import 'package:hk_acg_event_information/Screen/favouriteScreen.dart';
import 'package:hk_acg_event_information/Widget/eventCategoryLabel.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';
import 'package:hk_acg_event_information/model/enumCategory.dart';

class Eventscreen extends StatefulWidget {
  const Eventscreen({super.key});

  @override
  State<Eventscreen> createState() => _EventscreenState();
}

class _EventscreenState extends State<Eventscreen> {
  List<Event>? filterList;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: EvenCategory.values.length,
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
                        return const EventCalendarScreen();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_month)),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const FavouriteScreen();
                    },
                  ),
                );
              }, //OpenFavouriteScreen
              icon: const Icon(
                Icons.bookmark,
              ),
            ),
            const SizedBox(width: 5)
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            // isScrollable: true,
            tabs: [
              Tab(text: '全部'), //1
              Tab(text: '動漫展'), //2
              Tab(text: '同人展'), //3
              Tab(text: 'only場'), //4
              // Tab(text: '動漫電音節'), //5
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CategoryScreen(),
            CategoryScreen(selecedEvenCategory: EvenCategory.acg),
            CategoryScreen(selecedEvenCategory: EvenCategory.comicMarket),
            CategoryScreen(selecedEvenCategory: EvenCategory.only),
          ],
        ),
      ),
    );
  }
}
