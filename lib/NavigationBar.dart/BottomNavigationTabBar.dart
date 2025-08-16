import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/NavigationPage.dart/LoginScreen.dart';
import 'package:hk_acg_event_information/NavigationPage.dart/eventScreen.dart';
import 'package:hk_acg_event_information/NavigationPage.dart/homeScreen.dart';
import 'package:hk_acg_event_information/NavigationPage.dart/memberSetting_Screen.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';
import 'package:hk_acg_event_information/model/user_profile_model.dart';
import 'package:hk_acg_event_information/provider/pageNavigation_provider.dart';
import 'package:hk_acg_event_information/provider/userProvider.dart';

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
    final userProfile = ref.watch(userProvider);

    List<Widget> displayScreen = [
      const Homescreen(), //首頁
      const Eventscreen(), //活動
      const Center(child: Text('wip')),
      userProfile.isLogin ? const MembersettingScreen() : const LoginScreen()
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
      body: displayScreen[selectedPageIndex],
    );
  }
}
