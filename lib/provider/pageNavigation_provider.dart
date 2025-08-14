import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageNavigationNotifier extends StateNotifier<int> {
  PageNavigationNotifier() : super(0);

  onPageChage(int pageIndex) {
    state = pageIndex;
  }
}

final pageNavigationProvider =
    StateNotifierProvider<PageNavigationNotifier, int>((ref) {
  return PageNavigationNotifier();
});
