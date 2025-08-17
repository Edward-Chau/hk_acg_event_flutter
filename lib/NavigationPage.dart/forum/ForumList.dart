import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/provider/thread_provider.dart';

class ForumList extends ConsumerWidget {
  const ForumList({required this.type, super.key});
  final String type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestAsync = ref.watch(threadProvider(type));
    return latestAsync.when(
      data: (threads) => threads.isEmpty
          ? const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Text(
                '沒有任何討論',
                textAlign: TextAlign.center,
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await ref.read(threadProvider(type).notifier).refresh(type);
              },
              child: ListView.builder(
                itemCount: threads.length,
                itemBuilder: (_, index) => ListTile(
                  title: Text(threads[index].threadTitle),
                ),
              ),
            ),
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: CircularProgressIndicator(),
      ),
      error: (e, st) => Center(child: Text('錯誤: $e')),
    );
  }
}
