import 'package:cube_timer_2/database/models/category_model.dart';
import 'package:cube_timer_2/database/models/cube_type_model.dart';
import 'package:cube_timer_2/database/repositories/category_repository.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

class ActualCategoryOptions {
  final CategoryModel actualCategory;
  final List<CategoryModel> listOfCategories;

  ActualCategoryOptions(
      {required this.actualCategory, required this.listOfCategories});

  ActualCategoryOptions copyWith({
    CategoryModel? actualCategory,
    List<CategoryModel>? listOfCategories,
  }) {
    return ActualCategoryOptions(
      actualCategory: actualCategory ?? this.actualCategory,
      listOfCategories: listOfCategories ?? this.listOfCategories,
    );
  }
}

final categoryFutureProvider = FutureProvider<List<CategoryModel>>((ref) async {
  
  final CubeTypeModel currentCubeType = ref.watch(cubeTypeProvider).actualCubeType;
  final dbHelper = CategoryRepository();
  final categories = await dbHelper.getCategories(currentCubeType.id);

  return categories;
});


/// The [CategoryNotifier] class is a state notifier that manages the state of
/// the actual category options in the application. It extends the [StateNotifier]
/// class from the Riverpod package and provides methods to initialize the state,
/// set the category list, set the actual category, and check the category list.
/// It uses the [CategoryRepository] to interact with the database and retrieve
/// category data based on the current cube type.
class CategoryNotifier extends StateNotifier<ActualCategoryOptions> {
  CategoryNotifier(this.ref)
      : super(ActualCategoryOptions(
            actualCategory: CategoryModel(name: "", cubeTypeId: 1), listOfCategories: [])) {
    _initState();
  }

  final Ref ref;

  Future<void> _initState() async {
    final List<CategoryModel> categoriesByActualCubeType =
        await ref.read(categoryFutureProvider.future);

    state = state.copyWith(
      actualCategory: categoriesByActualCubeType[0],
      listOfCategories: categoriesByActualCubeType,
    );
  }

  Future<void> setCategoryList(int idNewCubeType) async {
    debugPrint("setCategoryList $idNewCubeType");
    final CubeTypeModel actualCubeType =
        ref.read(cubeTypeProvider).actualCubeType;
    final dbHelper = CategoryRepository();

    if (idNewCubeType != actualCubeType.id) {
      final List<CategoryModel> newCategories =
          await dbHelper.getCategories(idNewCubeType);

      // Sort the categories alphabetically by name
      // newCategories.sort((a, b) => a.name.compareTo(b.name));

      state = state.copyWith(
        listOfCategories: newCategories,
        actualCategory: newCategories[0]
      );
    }
  }

  Future<void> setActualCategory(int idCategory) async {
    if (state.actualCategory.id == idCategory) {
      return;
    }
    //getfromdatabase the category by idCategory
    final dbHelper = CategoryRepository();
    final CategoryModel? category = await
        dbHelper.getCategoryById(idCategory);

    state = state.copyWith(
      actualCategory: category ??
          CategoryModel(name: "", cubeTypeId: 1),
    );
  }

}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, ActualCategoryOptions>(
  (ref) => CategoryNotifier(ref),
);
