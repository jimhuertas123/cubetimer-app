import 'package:cube_timer_2/database/data/database_helper.dart';
import 'package:cube_timer_2/database/models/category_model.dart';

class CategoryRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertCategory(CategoryModel category) async {
    final db = await _databaseHelper.database;
    await db.insert('Category', category.toMap());
  }

  /// Class Category{
  /// \@required int id,
  /// \@required String name,
  /// \@required int cubeTypeId,
  /// \@required CubeType cubeType,}
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

  Future<void> updateCategory(CategoryModel category) async {
    final db = await _databaseHelper.database;
    await db.update(
      'Category',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<void> deleteCategory(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'Category',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<CategoryModel?> getCategoryById(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Category',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return CategoryModel.fromMap(maps.first);
    }
    return null;
  }

  //serach category by name and cubeTypeId
  Future<List<CategoryModel>> searchCategory(
      String name, int cubeTypeId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Category',
      where: 'name LIKE ? AND cubeTypeId = ?',
      whereArgs: ['%$name%', cubeTypeId],
    );
    return List.generate(maps.length, (i) {
      return CategoryModel.fromMap(maps[i]);
    });
  }
}