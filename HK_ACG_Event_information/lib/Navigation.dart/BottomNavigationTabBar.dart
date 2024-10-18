import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/BottomTabBarScreen.dart/acgNewsScreen.dart';
import 'package:hk_acg_event_information/BottomTabBarScreen.dart/eventScreen.dart';
import 'package:hk_acg_event_information/BottomTabBarScreen.dart/homeScreen.dart';
import 'package:hk_acg_event_information/data/EventDate.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';

class BottomNavigationTabBar extends StatefulWidget {
  const BottomNavigationTabBar({super.key});

  @override
  State<BottomNavigationTabBar> createState() => _BottomNavigationTabBarState();
}

int selectedPage = 0;
List<Event> favoriteEvent = [];

class _BottomNavigationTabBarState extends State<BottomNavigationTabBar> {
  @override
  Widget build(BuildContext context) {
    List<Event> eventList = registeredEvent;

    void keep(Event eventitem) {
      bool eventexisted = favoriteEvent.contains(eventitem);
      if (eventexisted == true) {
        setState(() {
          favoriteEvent.remove(eventitem);
        });
      } else {
        setState(() {
          favoriteEvent.add(eventitem);
        });
      }
    }

    List<Widget> showPage = [
      Homescreen(
        eventList: eventList,
        favoriteEventList: favoriteEvent,
        keep: keep,
      ), //首頁
      Eventscreen(
        eventList: eventList,
        keep: keep,
        favoriteEvent: favoriteEvent,
      ), //活動
      const Acgnewsscreen(), //acgnew
    ]; //navigattionScreen

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPage,
        selectedItemColor: Colors.blue,
        onTap: (value) {
          setState(
            () {
              selectedPage = value;
            },
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '活動'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'acg最新消息')
        ],
      ),
      body: showPage[selectedPage],
    );
  }
}
