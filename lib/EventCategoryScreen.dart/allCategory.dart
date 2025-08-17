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

    List<Event> filterEvent(events) {
      if (selecedEvenCategory != null) {
        final event = events
            .where((event) => event.evenCategory == selecedEvenCategory)
            .toList();

        return event;
      }

      return events;
    }

    return Container(
      color: ETAColors.screenBackgroundColor,
      child: eventList.when(
        data: (eventLists) {
          final List<Event> filterEvents = filterEvent(eventLists);

          return filterEvents.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 8),
                  child: Text(
                    '找不到活動',
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemCount: filterEvents.length,
                  itemBuilder: (context, index) {
                    return EventListtilecard(
                      event: filterEvents[index],
                    );
                  },
                );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Text('Error: $err'),
      ),
    );
  }
}
