import 'package:flutter/material.dart';
import 'package:hk_acg_event_information/BottomTabBarScreen.dart/acgNewsScreen.dart';
import 'package:hk_acg_event_information/BottomTabBarScreen.dart/eventScreen.dart';
import 'package:hk_acg_event_information/BottomTabBarScreen.dart/homeScreen.dart';
import 'package:hk_acg_event_information/BottomTabBarScreen.dart/membership_screen.dart';
import 'package:hk_acg_event_information/data/EventDate.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';
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
    void navigateToEventPage() {
      setState(() {
        selectedPage = 1;
      });
    }

    List<Widget> showPage = [
      Homescreen(navigateToEventPage: navigateToEventPage), //首頁
      const Eventscreen(), //活動
      const MembershipScreen()
    ]; //navigattionScreen

    return Scaffold(
      bottomNavigationBar:
          // NavigationBar(
          //   backgroundColor: ETAColors.appbarColors_01,
          //   selectedIndex: selectedPage,
          //   onDestinationSelected: (value) {
          //     setState(() {
          //       selectedPage = value;
          //     });
          //   },
          //   destinations: const [
          //     NavigationDestination(icon: Icon(Icons.home), label: '首頁'),
          //     NavigationDestination(icon: Icon(Icons.newspaper), label: '活動'),
          //     NavigationDestination(icon: Icon(Icons.home), label: '最新消息'),
          //     NavigationDestination(icon: Icon(Icons.person), label: '會員中心')
          //   ],
          // ),

          BottomNavigationBar(
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
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: '活動'),
          // BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: '最新消息'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '會員中心'),
        ],
      ),
      body: showPage[selectedPage],
    );
  }
}
