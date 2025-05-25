import 'package:cube_timer_2/compute/compute.dart';

//color map by default
const Map<int, String> _defaultColorMap = {
  0: '#ffffff', // Blanco
  1: '#ff8000', // Naranja
  2: '#00ff00', // Verde
  3: '#ff0000', // Rojo
  4: '#0000ff', // Azul
  5: '#ffff00', // Amarillo
};

/// This class is used to generate the SVG of a cube with the colors of the stickers
///if [colorMap] is not provided, it will use the default color map
class CubeSvgGenerator {
  final Matrix matrix;
  final Map<int, String> colorMap;

  const CubeSvgGenerator(
      {this.colorMap = _defaultColorMap, required this.matrix});

  String updateCubeSvgColors(
      String svg, Matrix matrix, Map<int, String> colorMap) {
    // Orden de las caras en el SVG: L, D, B, R, U, F
    final faceOrder = [Face.L, Face.D, Face.B, Face.R, Face.U, Face.F];

    // Junta todas las matrices de las caras en el orden correcto
    final allStickers = <int>[];
    for (final face in faceOrder) {
      final faceMatrix = matrix.getFace(face);
      for (final row in faceMatrix) {
        allStickers.addAll(row);
      }
    }
    int idx = 0;
    // Reemplaza cada fill en el SVG por el color correspondiente
    return svg.replaceAllMapped(RegExp(r'fill="#[0-9a-fA-F]{6}"'), (match) {
      if (idx >= allStickers.length) return match[0]!; // por si hay más rects de la cuenta
      final color = colorMap[allStickers[idx]] ?? '#000000';
      idx++;
      return 'fill="$color"';
    });
  }
}
