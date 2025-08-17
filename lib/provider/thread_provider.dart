import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/model/ThreadModel.dart';
import 'package:hk_acg_event_information/model/User_profile_model.dart';
import 'package:hk_acg_event_information/provider/dio_provider.dart';

class ThreadNotifier extends FamilyAsyncNotifier<List<Thread>, String> {
  late final String _type; // 存起來，方便 refresh 使用

  @override
  Future<List<Thread>> build(String type) async {
    _type = type;
    return _fetchThreads(type);
  }

  Future<List<Thread>> _fetchThreads(String type) async {
    final dio = ref.read(dioProvider);
    try {
      return [];
      return [Thread(author: UserProfile(), threadTitle: 'test')];
      final response = await dio.get('/threads', queryParameters: {
        'type': type, // "latest" 或 "hot"
      });

      final data = (response.data['data'] as List<dynamic>? ?? [])
          .map((e) => Thread.fromJson(e))
          .toList();
      return data;
    } catch (e, st) {
      print('❌ Thread fetch error: $e');
      throw e;
    }
  }

  // 刷新
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchThreads(_type));
  }
}

// Family Provider
final threadProvider =
    AsyncNotifierProviderFamily<ThreadNotifier, List<Thread>, String>(
        ThreadNotifier.new);
