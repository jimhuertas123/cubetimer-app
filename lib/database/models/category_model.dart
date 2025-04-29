import 'package:cube_timer_2/config/database/config_database.dart';

class CategoryModel {
  final int id;
  final String name;
  final int cubeTypeId;
  final CubeType? cubeType;

  CategoryModel({
    required this.id, 
    required this.name,
    required this.cubeTypeId,
    this.cubeType
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cubeTypeId': cubeTypeId,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      cubeTypeId: map['cubeTypeId'],
      cubeType: map['cubeType'] != null ? CubeTypeExtension.fromName(map['cubeType']) : null,
    );
  }
}