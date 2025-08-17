import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/NavigationPage.dart/forum/ForumList.dart';
import 'package:hk_acg_event_information/provider/thread_provider.dart';

class ForumScreen extends ConsumerWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hotAsync = ref.watch(threadProvider('hot'));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('討論區'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '最新'),
              Tab(text: '熱門'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const ForumList(type: 'latest'),
            hotAsync.when(
              data: (threads) => ListView.builder(
                itemCount: threads.length,
                itemBuilder: (_, index) => ListTile(
                  title: Text(threads[index].threadTitle),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('錯誤: $e')),
            ),
          ],
        ),
      ),
    );
  }
}
