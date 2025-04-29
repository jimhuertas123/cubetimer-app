import 'package:flutter_riverpod/flutter_riverpod.dart';

class CronometerStatusRunner {
  CronometerStatusRunner({
    required this.isRunning,
    required this.breakNewRecord,
  });

  bool isRunning;
  bool breakNewRecord;

  CronometerStatusRunner copyWith({
    bool? isRunning,
    bool? breakNewRecord,
  }) {
    return CronometerStatusRunner(
      isRunning: isRunning ?? this.isRunning,
      breakNewRecord: breakNewRecord ?? this.breakNewRecord,
    );
  }
}

/// This provider is used to manage the state of the Cronometer Runner page.
class CronometerStatusNotifier extends StateNotifier<CronometerStatusRunner> {
  CronometerStatusNotifier() : super(CronometerStatusRunner(
    isRunning: false,
    breakNewRecord: false,
  ));

  void isTimerRunning(bool isRunning) {
    state = state.copyWith(isRunning: isRunning);
  }

  void breakedNewRecord(bool breakNewRecord) {
    state = state.copyWith(breakNewRecord: breakNewRecord);
  }
}

final cronometerRunnerProvider =
    StateNotifierProvider<CronometerStatusNotifier, CronometerStatusRunner>((ref) {
  return CronometerStatusNotifier();
});