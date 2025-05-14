
import 'package:cube_timer_2/database/models/cube_type_model.dart';

// ignore: constant_identifier_names
const String DATABASE_NAME = 'cube_timer.db';

List<CubeTypeModel> initCubeTypes = [
  CubeTypeModel(
    id: 0,
    type: CubeType.twoByTwo,
  ),
  CubeTypeModel(
    id: 1,
    type: CubeType.threeByThree,
  ),
  CubeTypeModel(
    id: 2,
    type: CubeType.fourByFour,
  ),
  CubeTypeModel(
    id: 3,
    type: CubeType.fiveByFive,
  ),
  CubeTypeModel(
    id: 4,
    type: CubeType.sixBySix,
  ),
  CubeTypeModel(
    id: 5,
    type: CubeType.sevenBySeven,
  ),
];

enum CubeType {
  twoByTwo,
  threeByThree,
  fourByFour,
  fiveByFive,
  sixBySix,
  sevenBySeven,
}

extension CubeTypeExtension on CubeType {
  String get name {
    switch (this) {
      case CubeType.twoByTwo:
        return '2x2';
      case CubeType.threeByThree:
        return '3x3';
      case CubeType.fourByFour:
        return '4x4';
      case CubeType.fiveByFive:
        return '5x5';
      case CubeType.sixBySix:
        return '6x6';
      case CubeType.sevenBySeven:
        return '7x7';
    }
  }

  static CubeType fromName(String name) {
    switch (name) {
      case '3x3':
        return CubeType.threeByThree;
      case '2x2':
        return CubeType.twoByTwo;
      case '4x4':
        return CubeType.fourByFour;
      case '5x5':
        return CubeType.fiveByFive;
      case '6x6':
        return CubeType.sixBySix;
      case '7x7':
        return CubeType.sevenBySeven;
      default:
        throw ArgumentError('Invalid cube type name: $name');
    }
  }
}