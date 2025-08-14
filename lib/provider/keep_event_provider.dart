import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeepEventProviderNotifier extends StateNotifier<List<String>> {
  KeepEventProviderNotifier() : super([]) {
    getKeepList();
  }

  Future<void> getKeepList() async {
    final prefs = await SharedPreferences.getInstance();
    // 存字串清單
    state = prefs.getStringList('keepList') ?? [];
  }

  /// 切換收藏狀態
  Future<bool> toggleKeep(String documentId) async {
    if (!state.contains(documentId)) {
      state = [...state, documentId];
      await updateKeepList();
      return true;
    } else {
      state = state.where((id) => id != documentId).toList();
      await updateKeepList();
      return false;
    }
  }

  Future<void> updateKeepList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('keepList', state);
  }
}

final keepEventProviderProvider =
    StateNotifierProvider<KeepEventProviderNotifier, List<String>>((ref) {
  return KeepEventProviderNotifier();
});
