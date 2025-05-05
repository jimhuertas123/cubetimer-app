import 'package:cube_timer_2/config/database/config_database.dart';
import 'package:cube_timer_2/database/data/database_helper.dart';
import 'package:cube_timer_2/database/models/category_model.dart';
import 'package:cube_timer_2/database/models/cube_type_model.dart';
import 'package:cube_timer_2/database/repositories/category_repositoy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  CubeTypeNotifier()
      : super(ActualCubeOptions(
            actualCubeType: CubeTypeModel(id: 1, type: CubeType.threeByThree),
            cubeTypes: <CubeTypeModel>[])) {
    _loadCubeTypes();
  }

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

  void setCurrentCubeType(CubeTypeModel newCubeType) {
    state = state.copyWith(
      actualCubeType: newCubeType,
    );
  }

  CubeTypeModel get currentCubeType => state.actualCubeType;
}

final cubeTypeProvider =
    StateNotifierProvider<CubeTypeNotifier, ActualCubeOptions>(
  (ref) => CubeTypeNotifier(),
);

/// This class is used to manage the state of categories in the app.
/// It extends StateNotifier and takes a list of CategoryModel as its state.
/// The class provides a method to load categories for the current cube type
/// and updates the state accordingly.
///
/// The loadCategoriesForCurrentCubeType method retrieves the current cube type
/// from the cubeTypeProvider and uses the CategoryRepository to fetch the
/// categories associated with that cube type. If the current cube type is null,
/// the state is set to an empty list.
class CategoryNotifier extends StateNotifier<List<CategoryModel>> {
  CategoryNotifier(this.ref) : super([]);

  final Ref ref;

  Future<List<CategoryModel>> loadCategoriesForCurrentCubeType(CubeTypeModel actualOption) async {
    final CubeTypeModel currentCubeType = ref.read(cubeTypeProvider).actualCubeType;

    final dbHelper = CategoryRepository();
    state = await dbHelper.getCategories(currentCubeType.id);
    return state;
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<CategoryModel>>(
  (ref) => CategoryNotifier(ref),
);
