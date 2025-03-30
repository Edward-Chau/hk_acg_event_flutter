import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/Widget/EventListTileCard.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';
import 'package:hk_acg_event_information/model/enumCategory.dart';
import 'package:hk_acg_event_information/provider/event_list_provider.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key, this.selecedEvenCategory});

  final EvenCategory? selecedEvenCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLoading = ref.watch(eventListProvider).isLoading;
    List<Event> eventList = ref.watch(eventListProvider).eventList;

    if (selecedEvenCategory != null) {
      eventList = eventList
          .where((event) => event.evenCategory == selecedEvenCategory)
          .toList();
    }
    return Container(
      color: ETAColors.screenBackgroundColor,
      child: Scrollbar(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : eventList.isEmpty
                ? const Center(
                    child: Text('找不到活動'),
                  )
                : ListView.builder(
                    itemCount: eventList.length,
                    itemBuilder: (context, index) {
                      return EventListtilecard(
                        event: eventList[index],
                      );
                    },
                  ),
      ),
    );
  }
}
