//cube type
enum CubeType {
  cube2x2,
  cube3x3,
  cube4x4,
  cube5x5,
  cube6x6,
  cube7x7
}

final Map<CubeType, String> cubeTypeToString = {
  CubeType.cube2x2: '2x2 Cube',
  CubeType.cube3x3: '3x3 Cube',
  CubeType.cube4x4: '4x4 Cube',
  CubeType.cube5x5: '5x5 Cube',
  CubeType.cube6x6: '6x6 Cube',
  CubeType.cube7x7: '7x7 Cube',
};