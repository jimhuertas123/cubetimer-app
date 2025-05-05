
const String DATABASE_NAME = 'cube_timer.db';

enum CubeType {
  threeByThree,
  twoByTwo,
  fourByFour,
  fiveByFive,
  sixBySix,
  sevenBySeven,
}

extension CubeTypeExtension on CubeType {
  String get name {
    switch (this) {
      case CubeType.threeByThree:
        return '3x3';
      case CubeType.twoByTwo:
        return '2x2';
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