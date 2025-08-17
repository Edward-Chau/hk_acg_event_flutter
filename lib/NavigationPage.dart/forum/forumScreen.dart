import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/NavigationPage.dart/forum/ForumList.dart';
import 'package:hk_acg_event_information/NavigationPage.dart/forum/newThread.dart';

class ForumScreen extends ConsumerWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (ctx) => const Newthread()),
            );
          },
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: const Text('討論區'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '最新'),
              Tab(text: '熱門'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ForumList(type: 'latest'),
            ForumList(type: 'hot'),
          ],
        ),
      ),
    );
  }
}
