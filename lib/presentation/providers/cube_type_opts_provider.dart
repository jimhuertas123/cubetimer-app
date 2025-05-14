import 'package:cube_timer_2/config/database/config_database.dart';
import 'package:cube_timer_2/database/data/database_helper.dart';
import 'package:cube_timer_2/database/models/cube_type_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

class ActualCubeOptions {
  final CubeTypeModel actualCubeType;
  final List<CubeTypeModel> cubeTypes;

  ActualCubeOptions({required this.actualCubeType, required this.cubeTypes});

  ActualCubeOptions copyWith({
    CubeTypeModel? actualCubeType,
    List<CubeTypeModel>? cubeTypes,
  }) {
    return ActualCubeOptions(
      actualCubeType: actualCubeType ?? this.actualCubeType,
      cubeTypes: cubeTypes ?? this.cubeTypes,
    );
  }
}

class CubeTypeNotifier extends StateNotifier<ActualCubeOptions> {
  CubeTypeNotifier(this.ref)
      : super(ActualCubeOptions(
            actualCubeType: CubeTypeModel(id: 1, type: CubeType.threeByThree),
            cubeTypes: <CubeTypeModel>[])) {
    _loadCubeTypes();
  }

  final Ref ref;

  Future<void> _loadCubeTypes() async {
    final dbHelper = DatabaseHelper();
    final db = await dbHelper.database;
    final maps = await db.query('CubeType');
    state = state.copyWith(
      cubeTypes: List.generate(maps.length, (i) {
        return CubeTypeModel.fromMap(maps[i]);
      }),
      actualCubeType: CubeTypeModel.fromMap(maps[1]),
    );
  }

  Future<void> setCurrentCubeType(CubeTypeModel newCubeType) async {
    if (newCubeType == state.actualCubeType) return;
    
    // Update the categories provider based on the new cube type
    final categoriesProvider = ref.read(categoryProvider.notifier);
    await categoriesProvider.setCategoryList(newCubeType.id);


    state = state.copyWith(
      actualCubeType: newCubeType,
    );
  }

  CubeTypeModel get currentCubeType => state.actualCubeType;
}

final cubeTypeProvider =
    StateNotifierProvider<CubeTypeNotifier, ActualCubeOptions>(
  (ref) => CubeTypeNotifier(ref),
);