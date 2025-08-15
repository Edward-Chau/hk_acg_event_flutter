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
      // await eventListWithRetryOnError();
      throw e;
    }
  }

  Future<bool> updateEventList() async {
    state = const AsyncLoading();
    try {
      state = await AsyncValue.guard(() => _fetchAllEvents());
      print('updated');
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      // await eventListWithRetryOnError();
      return false;
    }
  }

  Future<void> eventListWithRetryOnError() async {
    while (true) {
      final success = await updateEventList();
      if (success) break; // 成功就跳出
      print('⏳ 5 秒後重試...');
      await Future.delayed(const Duration(seconds: 5));
    }
  }
}

final eventProvider =
    AsyncNotifierProvider<EventNotifier, List<Event>>(EventNotifier.new);
