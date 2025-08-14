import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/NavigationPage.dart/acgNewsScreen.dart';
import 'package:hk_acg_event_information/NavigationPage.dart/eventScreen.dart';
import 'package:hk_acg_event_information/NavigationPage.dart/homeScreen.dart';
import 'package:hk_acg_event_information/NavigationPage.dart/membership_screen.dart';
import 'package:hk_acg_event_information/data/EventDate.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';
import 'package:hk_acg_event_information/provider/pageNavigation_provider.dart';

class BottomNavigationTabBar extends ConsumerStatefulWidget {
  const BottomNavigationTabBar({super.key});

  @override
  ConsumerState<BottomNavigationTabBar> createState() =>
      _BottomNavigationTabBarState();
}

List<Event> favoriteEvent = [];

class _BottomNavigationTabBarState
    extends ConsumerState<BottomNavigationTabBar> {
  @override
  Widget build(BuildContext context) {
    final int selectedPageIndex = ref.watch(pageNavigationProvider);

    List<Widget> displayScreen = [
      const Homescreen(), //首頁
      const Eventscreen(), //活動
      const MembershipScreen(),
      const MembershipScreen()
    ]; //navigattionScreen

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.grey[100]!.withOpacity(0.5),
        selectedIndex: selectedPageIndex,
        shadowColor: Colors.black,
        indicatorColor: Colors.blueAccent[100],
        onDestinationSelected: (value) {
          ref.read(pageNavigationProvider.notifier).onPageChage(value);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: '首頁'),
          NavigationDestination(icon: Icon(Icons.newspaper), label: '活動'),
          NavigationDestination(icon: Icon(Icons.chat_outlined), label: '討論'),
          NavigationDestination(icon: Icon(Icons.person), label: '會員中心')
        ],
      ),
      //   BottomNavigationBar(
      //   currentIndex: selectedPage,
      //   selectedItemColor: Colors.blue,
      //   onTap: (value) {
      //     setState(
      //       () {
      //         selectedPage = value;
      //       },
      //     );
      //   },
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
      //     BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: '活動'),
      //     // BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: '最新消息'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: '會員中心'),
      //   ],
      // ),
      body: displayScreen[selectedPageIndex],
    );
  }
}
