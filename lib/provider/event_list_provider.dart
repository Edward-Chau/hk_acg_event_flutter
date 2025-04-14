import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/data/EventDate.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';

class EventListNotifier extends StateNotifier<ProvideEventClass> {
  EventListNotifier()
      : super(const ProvideEventClass(isLoading: true, eventList: [])) {
    getEventList();
  }

  getEventList() async {
    state = ProvideEventClass(
      isLoading: false,
      eventList: await ProvideData.getEventList(),
    );
    print("get event list");
  }

  updateEventList() {
    HapticFeedback.mediumImpact();
    state = ProvideEventClass(
      isLoading: true,
      eventList: state.eventList,
    );
    //call get function
    getEventList();
    print('updated');
    HapticFeedback.mediumImpact();
  }
}

final eventListProvider =
    StateNotifierProvider<EventListNotifier, ProvideEventClass>((ref) {
  return EventListNotifier();
});

class ProvideEventClass {
  const ProvideEventClass({
    this.isLoading = true,
    required this.eventList,
  });

  final bool isLoading;
  final List<Event> eventList;
}
