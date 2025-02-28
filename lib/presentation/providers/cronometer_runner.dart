import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This provider is used to manage the state of the Cronometer Runner page.

class CronometerRunnerNotifier extends StateNotifier<bool> {
  CronometerRunnerNotifier() : super(false);

  void isTimerRunning(bool isRunning) {
    state = isRunning;
  }
}

final cronometerRunnerProvider =
    StateNotifierProvider<CronometerRunnerNotifier, bool>((ref) {
  return CronometerRunnerNotifier();
});