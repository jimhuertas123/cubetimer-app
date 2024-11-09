import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageIndexIntNotifier extends StateNotifier<int> {
  PageIndexIntNotifier() : super(0);

  void setPageIndex(int index) {
    state = index;
  }
}

final pageIndexProviderInt =
    StateNotifierProvider<PageIndexIntNotifier, int>((ref) {
  return PageIndexIntNotifier();
});