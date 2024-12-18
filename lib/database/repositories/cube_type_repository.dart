import 'package:cube_timer_2/database/models/cube_type_model.dart';
import '../data/database_helper.dart';

class CubeTypeRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertCubeType(CubeTypeModel cubeType) async {
    final db = await _databaseHelper.database;
    await db.insert('CubeType', cubeType.toMap());
  }

  Future<List<CubeTypeModel>> getCubeTypes() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('CubeType');
    return List.generate(maps.length, (i) {
      return CubeTypeModel.fromMap(maps[i]);
    });
  }
}