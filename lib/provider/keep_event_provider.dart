import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/data/EventDate.dart';
import 'package:hk_acg_event_information/model/EventModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeepEventProviderNotifier extends StateNotifier<List<int>> {
  KeepEventProviderNotifier() : super([]) {
    getKeedList();
  }

  getKeedList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> keepListOfString = prefs.getStringList('keepList') ?? [];
    List<int> intList = keepListOfString.map(int.parse).toList();
    state = intList;
  }

  Future<bool> toggleKeep(int eventId) async {
    if (!state.contains(eventId)) {
      state = [...state, eventId];
      updateKeepList();
      return true;
    } else {
      state = state.where((id) => id != eventId).toList();
      updateKeepList();
      return false;
    }
  }

  updateKeepList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> keepListOfString = state.map((e) => e.toString()).toList();
    prefs.setStringList('keepList', keepListOfString);
  }
}

final keepEventProviderProvider =
    StateNotifierProvider<KeepEventProviderNotifier, List<int>>((ref) {
  return KeepEventProviderNotifier();
});
