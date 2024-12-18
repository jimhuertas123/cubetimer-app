import 'package:cube_timer_2/database/data/database_helper.dart';
import 'package:cube_timer_2/database/models/category_model.dart';

class CategoryRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertCategory(CategoryModel category) async {
    final db = await _databaseHelper.database;
    await db.insert('Category', category.toMap());
  }

  Future<List<CategoryModel>> getCategories(int cubeTypeId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Category',
      where: 'cubeTypeId = ?',
      whereArgs: [cubeTypeId],
    );
    return List.generate(maps.length, (i) {
      return CategoryModel.fromMap(maps[i]);
    });
  }
}