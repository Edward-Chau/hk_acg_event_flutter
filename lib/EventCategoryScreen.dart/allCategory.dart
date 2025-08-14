import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/Widget/EventListTileCard.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';

import 'package:hk_acg_event_information/provider/event_list_provider.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key, this.selecedEvenCategory});

  final EvenCategory? selecedEvenCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventList = ref.watch(eventProvider);

    // if (selecedEvenCategory != null) {
    //   eventList = eventList
    //       .where((event) => event.evenCategory == selecedEvenCategory)
    //       .toList();
    // }
    return Container(
      color: ETAColors.screenBackgroundColor,
      child: Scrollbar(
          child: eventList.when(
        data: (eventLists) => eventLists.isEmpty
            ? const Center(
                child: Text('找不到活動'),
              )
            : ListView.builder(
                itemCount: eventLists.length,
                itemBuilder: (context, index) {
                  return EventListtilecard(
                    event: eventLists[index],
                  );
                },
              ),
        loading: () => const CircularProgressIndicator(),
        error: (err, _) => Text('Error: $err'),
      )),
    );
  }
}
