import 'package:cube_timer_2/config/database/config_database.dart';

class CubeTypeModel {
  final int id;
  final CubeType type;

  CubeTypeModel({required this.id, required this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.name,
    };
  }

  factory CubeTypeModel.fromMap(Map<String, dynamic> map) {
    return CubeTypeModel(
      id: map['id'],
      type: CubeTypeExtension.fromName(map['type']),
    );
  }
}