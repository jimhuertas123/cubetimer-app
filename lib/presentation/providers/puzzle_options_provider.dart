import 'package:cube_timer_2/config/database/config_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleOptions {
  final CubeType puzzleOption;
  final String puzzleCategory;

  PuzzleOptions({
    this.puzzleOption = CubeType.threeByThree,
    this.puzzleCategory = "normal",
  });

  PuzzleOptions copyWith({
    CubeType? puzzleOption,
    String? puzzleCategory,
  }) {
    return PuzzleOptions(
      puzzleOption: puzzleOption ?? this.puzzleOption,
      puzzleCategory: puzzleCategory ?? this.puzzleCategory,
    );
  }
}

class PuzzleOptionsProvider extends StateNotifier<PuzzleOptions> {
  PuzzleOptionsProvider(): super(PuzzleOptions(
    puzzleOption: CubeType.threeByThree,
    puzzleCategory: "normal",
  ));
  

  void setPuzzleOption(int puzzleOption) {
    CubeType selectedPuzzleOption = CubeType.values[puzzleOption];
    state = state.copyWith(puzzleOption: selectedPuzzleOption);
  }

  void setPuzzleCategory(String puzzleCategory) {
    state = state.copyWith(puzzleCategory: puzzleCategory);
  }
}

final puzzleOptionsProvider = StateNotifierProvider<PuzzleOptionsProvider, PuzzleOptions>((ref) {
  return PuzzleOptionsProvider();
});

