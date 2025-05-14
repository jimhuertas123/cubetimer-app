// import '../puzzle_options/puzzle_options_enum.dart';

// ///Given a Type enum(Type.cube2x2, Type.cube3x3...) return an int from the respect type(2,3...)
// Map<CubeType, int> nCubeType = {
//   CubeType.cube2x2:2,
//   CubeType.cube3x3:3,
//   CubeType.cube4x4:4,
//   CubeType.cube5x5:5,
//   CubeType.cube6x6:6,
//   CubeType.cube7x7:7
// };

// Map<int,CubeType> intToType = {
//   2:CubeType.cube2x2,
//   3:CubeType.cube3x3,
//   4:CubeType.cube4x4,
//   5:CubeType.cube5x5,
//   6:CubeType.cube6x6,
//   7:CubeType.cube7x7
// };

// class Matrix {
//   List<List<int>> _matrix = List.generate(1, (i) => []);
//   CubeType? type;
//   int? length;

//   Matrix(CubeType typeCube, int element){
//     type= typeCube;
//     _matrix = List.generate(nCubeType[type]!, (index) => []);
//     for(var i=0; i<nCubeType[type]!; i++){
//       List<int> list = List.generate(nCubeType[type]!, (index) => element);
//       _matrix[i] = list;
//     }
//     length = _matrix.length;
//   }
  
//   void printMatrix(){
//     // ignore: unused_local_variable
//     String aux = "";
//     for(var i=0; i<_matrix.length; i++){
//       for(var j=0; j<_matrix[i].length; j++){
//         aux += _matrix[i][j].toString();
//         aux += " ";
//       }
//       // debugPrint(aux);
//       aux = "";
//     }
//   }
 
//   List<List<dynamic>> get matrix => _matrix;
//   void setElement(int i, int j, int color){
//     _matrix[i][j] = color;
//   }

//   dynamic operator[](int i){
//     return _matrix[i];
//   }

//   // late dynamic operator=(Matrix i){
//   //   return _matrix = i._matrix;
//   // };

//   void rotarMatrizHorario(){
//     int N = _matrix.length;//initial i
//     int swapAux = 0;
//     for(int i=1,k=0;i<N+1;i++,k++){
//       for(int j=N-i; j>-1; j--){
//         swapAux = _matrix[j][N-i];
//         _matrix[j][N-i] = _matrix[k][j];
//         _matrix[k][j] = swapAux;
//       }
//     }
//     for(int i=1;i<(N/2.0).round()+1;i++){
//         for(int j=i;j<N-i;j++){
//           swapAux = _matrix[j][i-1];
//           _matrix[j][i-1] = _matrix[N-i][j];
//           _matrix[N-i][j] = swapAux;
//         }
//     }
//   }

//   void rotarMatrizAntihorario(){
//     int swapAux = 0;
//     int N = _matrix.length;
//     for(int i=0;i<N;i++){
//       for(int j=i;j<N;j++){
//         swapAux = _matrix[i][j];
//         _matrix[i][j] = _matrix[N-j-1][i];
//         _matrix[N-j-1][i] = swapAux;
//       }
//     }
//     for(int i=1;i<(N/2.0).round()+1;i++){
//       for(int j=i;j<N-i;j++){
//         swapAux = _matrix[N-i][j];
//         _matrix[N-i][j] = _matrix[N-j-1][N-i];
//         _matrix[N-j-1][N-i] = swapAux;
//       }
//     }
//   }
// }