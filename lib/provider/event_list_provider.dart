import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';
import 'package:hk_acg_event_information/provider/dio_provider.dart';

class EventNotifier extends AsyncNotifier<List<Event>> {
  @override
  Future<List<Event>> build() async {
    return _fetchAllEvents();
  }

  Future<List<Event>> _fetchAllEvents() async {
    final dio = ref.read(dioProvider);
    try {
      final response = await dio.get('/all-events');
      final data = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => Event.fromJson(e))
          .toList();

      return data;
    } catch (e, st) {
      print('❌ Error: $e');
      throw e;
    }
  }

  Future<void> updateEventList() async {
    HapticFeedback.mediumImpact();
    state = const AsyncLoading();
    try {
      state = await AsyncValue.guard(() => _fetchAllEvents());
      print('updated');
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
    HapticFeedback.mediumImpact();
  }
}

final eventProvider =
    AsyncNotifierProvider<EventNotifier, List<Event>>(EventNotifier.new);
