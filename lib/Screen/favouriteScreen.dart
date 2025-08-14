import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/Widget/EventListTileCard.dart';
import 'package:hk_acg_event_information/model/ETAColor.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';
import 'package:hk_acg_event_information/provider/event_list_provider.dart';
import 'package:hk_acg_event_information/provider/keep_event_provider.dart';

class FavouriteScreen extends ConsumerStatefulWidget {
  const FavouriteScreen({super.key});

  @override
  ConsumerState<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends ConsumerState<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final eventList = ref.watch(eventProvider);
    final List<String> keepList = ref.watch(keepEventProviderProvider);

    //
    return Scaffold(
      backgroundColor: ETAColors.screenBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData().copyWith(color: Colors.white),
        title: const Text(
          '標記的活動',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: ETAColors.appbarColors_01,
      ),
      body: eventList.when(
        data: (eventlists) {
          final List<Event> keepListOfEvent = eventlists.where((event) {
            return keepList
                .contains(event.id); // Assuming Event has an 'id' field
          }).toList();
          return keepList.isEmpty
              ? const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "沒有標記任何的活動",
                      style: TextStyle(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: keepListOfEvent.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        EventListtilecard(
                          event: keepListOfEvent[index],
                        ),
                        if (keepListOfEvent.length - 1 == index)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text('共有 ${keepListOfEvent.length} 項收藏'),
                          ),
                      ],
                    );
                  },
                );
        },
        loading: () => const CircularProgressIndicator(),
        error: (err, _) => Text('Error: $err'),
      ),
    );
  }
}
