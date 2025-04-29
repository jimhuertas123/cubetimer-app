import 'package:cube_timer_2/database/data/database_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CubeTypeNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  CubeTypeNotifier() : super([]) {
    _loadCubeTypes();
  }

  Future<void> _loadCubeTypes() async {
    final dbHelper = DatabaseHelper();
    final db = await dbHelper.database;
    state = await db.query('CubeType');
  }

  void setCurrentCubeType(Map<String, dynamic> newCubeType) {
    state = [newCubeType];
  }

  Map<String, dynamic>? get currentCubeType =>
      state.isNotEmpty ? state.first : null;
}

final cubeTypeProvider =
    StateNotifierProvider<CubeTypeNotifier, List<Map<String, dynamic>>>(
  (ref) => CubeTypeNotifier(),
);