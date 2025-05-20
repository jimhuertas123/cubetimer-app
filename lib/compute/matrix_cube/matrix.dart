import 'package:cube_timer_2/config/database/config_database.dart';
import 'package:flutter/material.dart';

int getNcubeType(CubeType type) {
  switch (type) {
    case CubeType.twoByTwo:
      return 2;
    case CubeType.threeByThree:
      return 3;
    case CubeType.fourByFour:
      return 4;
    case CubeType.fiveByFive:
      return 5;
    case CubeType.sixBySix:
      return 6;
    case CubeType.sevenBySeven:
      return 7;
  }
}

enum Face { U, L, F, R, B, D }

extension FaceIndex on Face {
  int get index => Face.values.indexOf(this);
}

// 2x2 layers -> 0  n%2 ? (n/2)-1 : (n-1/2)-1
// 3x3 layers -> 0
// 4x4 layers -> 0, 1
// 5x5 layers -> 0, 1
// 6x6 layers -> 0, 1, 2
// 7x7 layers -> 0, 1, 2
/// The [AdjacentInfo] class represents the information about adjacent faces of a cube face.
/// It contains the face itself, a function to get the index of the adjacent face,
/// and a boolean indicating if the order of the adjacent face is reversed.
/// The [getIndex] function takes two parameters: n (the size of the cube) and layer (the layer number).
class AdjacentInfo {
  final Face face;
  final List<int?> Function(int n, int layer) getIndex;
  final bool reverseClockwise;
  final bool reverseCounterClockwise;
  const AdjacentInfo(
    this.face,
    this.getIndex, {
    this.reverseClockwise = false,
    this.reverseCounterClockwise = false,
  });
}



///For every CubeFace, define Adjacent faces for [rows,columns]
final Map<Face, List<AdjacentInfo>> adjacentMap = {
  //0:U
  Face.U: [
    AdjacentInfo(Face.B, (n, layer) => [layer, null]), // B firsts row
    AdjacentInfo(Face.R, (n, layer) => [layer, null]), // R firsts row
    AdjacentInfo(Face.F, (n, layer) => [layer, null]), // F firsts row
    AdjacentInfo(Face.L, (n, layer) => [layer, null]), // L firsts row
  ],

  //1:L
  Face.L: [
    AdjacentInfo(Face.U, (n, layer) => [null, layer], reverseClockwise: true), // U firsts column
    AdjacentInfo(Face.F, (n, layer) => [null, layer]), // F firsts column
    AdjacentInfo(Face.D, (n, layer) => [null, layer], reverseCounterClockwise: true), // D firsts column
    AdjacentInfo(Face.B, (n, layer) => [null, n - 1 - layer], reverseClockwise: true, reverseCounterClockwise: true), // B lasts column
  ],

  //2:F
  Face.F: [
    AdjacentInfo(Face.U, (n, layer) => [n - 1 - layer, null], reverseClockwise: true), // U lasts row
    AdjacentInfo(Face.R, (n, layer) => [null, layer], reverseCounterClockwise: true), // R firsts column
    AdjacentInfo(Face.D, (n, layer) => [layer, null], reverseClockwise: true), // D firsts row
    AdjacentInfo(Face.L, (n, layer) => [null, n - 1 - layer], reverseCounterClockwise: true), // L lasts column
  ],

  //3:R
  Face.R: [
    AdjacentInfo(Face.U, (n, layer) => [null, n - 1 - layer], reverseCounterClockwise: true), // U lasts column
    AdjacentInfo(Face.B, (n, layer) => [null, layer], reverseClockwise: true, reverseCounterClockwise: true), // B firsts column
    AdjacentInfo(Face.D, (n, layer) => [null, n - 1 - layer], reverseClockwise: true), // D lasts column
    AdjacentInfo(Face.F, (n, layer) => [null, n - 1 - layer]), // F lasts column
  ],

  //4:B
  Face.B: [
    AdjacentInfo(Face.U, (n, layer) => [layer, null], reverseCounterClockwise: true), // U firsts row
    AdjacentInfo(Face.L, (n, layer) => [null, layer], reverseClockwise: true), // L firsts column
    AdjacentInfo(Face.D, (n, layer) => [n - 1 - layer, null], reverseCounterClockwise: true), // D lasts row
    AdjacentInfo(Face.R, (n, layer) => [null, n - 1 - layer], reverseClockwise: true), // R lasts column
  ],

  //5:D
  Face.D: [
    AdjacentInfo(Face.F, (n, layer) => [n - 1 - layer, null]), // F lasts row
    AdjacentInfo(Face.R, (n, layer) => [n - 1 - layer, null]), // R lasts row
    AdjacentInfo(Face.B, (n, layer) => [n - 1 - layer, null]), // B lasts row
    AdjacentInfo(Face.L, (n, layer) => [n - 1 - layer, null]), // L lasts row
  ],
};




/// The [Matrix] class represents a bidimensional matrix used to model a cube's faces,
/// where each element in the matrix corresponds to a color represented by a number.
///
/// Represents the color mapping and structure of a Rubik's Cube as matrices.
///
/// Color mapping (by default):
///
/// - `0`: White ('U'p face)
/// - `1`: Orange ('L'eft face)
/// - `2`: Green ('F'ront face)
/// - `3`: Red ('R'ight face)
/// - `4`: Blue ('B'ack face)
/// - `5`: Yellow ('D'own face)
///
/// Each face of the cube is represented as a square matrix of size `NxN`,
/// where `N` is the dimension of the cube (e.g., 3 for a 3x3 cube, 4 for a 4x4 cube).
///
/// Example for a 3x3 cube:
/// ```dart
/// [
///   [0, 0, 0],
///   [0, 0, 0],
///   [0, 0, 0]
/// ] // Up face (White)
/// [
///   [1, 1, 1],
///   [1, 1, 1],
///   [1, 1, 1]
/// ] // Left face (Orange)
/// [
///   [2, 2, 2],
///   [2, 2, 2],
///   [2, 2, 2]
/// ] // Front face (Green)
/// [
///   [3, 3, 3],
///   [3, 3, 3],
///   [3, 3, 3]
/// ] // Right face (Red)
/// [
///   [4, 4, 4],
///   [4, 4, 4],
///   [4, 4, 4]
/// ] // Back face (Blue)
/// [
///   [5, 5, 5],
///   [5, 5, 5],
///   [5, 5, 5]
/// ] // Down face (Yellow)
/// ```
///
/// Example for a 4x4 cube (for any face):
/// ```dart
/// [
///   [color, color, color, color],
///   [color, color, color, color],
///   [color, color, color, color],
///   [color, color, color, color]
/// ]
/// ```
///
/// This structure allows for easy manipulation and visualization of each face of the cube.
class Matrix {
  late List<List<List<int>>> _cube; // 6 caras, cada una n x n
  final CubeType type;
  final int nCubeType;

  Matrix({
    required this.type,
  }) : nCubeType = getNcubeType(type) {
    int cont = 0;
    _cube = List.generate(
      6, // 6 caras
      (face) => List.generate(
        nCubeType, // n filas por cara
        (_) => List.generate(
              nCubeType, (_) => ++cont
            ), // color inicial = número de cara
      ),
    );
  }

  void printMatrix() {
    for (int i = 0; i < _cube.length; i++) {
      debugPrint('Cara $i:');
      for (int j = 0; j < _cube[i].length; j++) {
        debugPrint('${_cube[i][j]}');
      }
      debugPrint('');
    }
  }

  /// Returns the color of the element at the specified face, row, and column.
  List<List<int>> getFace(Face face) => _cube[face.index];

  /// Returns the color of the element at the specified face, row, and column.
  void setElement(Face face, int row, int col, int color) {
    _cube[face.index][row][col] = color;
  }

  /// Returns the color of the element at the specified face, row, and column.
  dynamic operator [](int i) {
    return _cube[i];
  }

  // rotates the layer of the cube based on the specified face and layer number.
  void rotateLayerbyFace(Face face, int layer, bool clockWise) {
    final n = nCubeType;

    // 1. Extract the strips from the adjacent faces
    List<List<int>> strips = [];
    for (final adj in adjacentMap[face]!) {
      final idx = adj.getIndex(n, layer);
      List<int> strip;
      if (idx[0] != null) {
        strip = List.from(_cube[adj.face.index][idx[0]!]);
      } else {
        strip = List.generate(n, (i) => _cube[adj.face.index][i][idx[1]!]);
      }
      strips.add(strip);
    }

    // 2. Rotate the strips (clockwise or counterclockwise)
    List<List<int>> rotatedStrips = List.generate(4, (i) => []);
    for (int i = 0; i < 4; i++) {
      rotatedStrips[(i + (clockWise ? 1 : 3)) % 4] = List<int>.from(strips[i]);
    }

    // 3. Assign the rotated strips back to the adjacent faces
    for (int i = 0; i < 4; i++) {
      final adj = adjacentMap[face]![i];
      final idx = adj.getIndex(n, layer);
      List<int> strip = List<int>.from(rotatedStrips[i]);
      // Apply reverse according to the direction and flags
      if ((clockWise && adj.reverseClockwise) || (!clockWise && adj.reverseCounterClockwise)) {
        strip = List<int>.from(strip.reversed);
      }
      if (idx[0] != null) {
        _cube[adj.face.index][idx[0]!] = strip;
      } else {
        for (int j = 0; j < n; j++) {
          _cube[adj.face.index][j][idx[1]!] = strip[j];
        }
      }
    }

    // 4. If it's the external layer, rotate the face matrix
    if (layer == 0) {
      _rotateFaceMatrix(face, clockWise);
    }
  }

  /// rotates the main face matrix (only for external layer (layer == 0)
  void _rotateFaceMatrix(Face face, bool clockWise) {
    final n = nCubeType;
    List<List<int>> old =
        List.generate(n, (i) => List.from(_cube[face.index][i]));
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        _cube[face.index][i][j] =
            clockWise ? old[n - j - 1][i] : old[j][n - i - 1];
      }
    }
  }
}

void main(List<String> args) {
  const CubeType type = CubeType.threeByThree;
  Matrix matrix = Matrix(type: type);

  const int layer = 0;
  matrix.rotateLayerbyFace(Face.D, layer, false);
  matrix.printMatrix();

}
