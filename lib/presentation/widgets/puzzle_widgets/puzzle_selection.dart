import 'package:cube_timer_2/presentation/widgets/puzzle_widgets/button_splash.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class PuzzleSelection extends ConsumerStatefulWidget {
//   const PuzzleSelection({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _PuzzleSelectionState();
// }

// class _PuzzleSelectionState extends ConsumerState<PuzzleSelection> {

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class PuzzleSelection extends StatefulWidget {
  const PuzzleSelection({super.key});

  @override
  State<PuzzleSelection> createState() => _PuzzleSelectionState();
}

class _PuzzleSelectionState extends State<PuzzleSelection> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;

    return Column(
      key: const Key('puzzle_selection'),
      children: <Widget>[
        const SizedBox(height: 13),
          ButtonSplash(
            addingIndex: 0, 
            screen: screen,
            padding: const EdgeInsets.symmetric(horizontal: 0),
          ),
          ButtonSplash(
            addingIndex: 3,
            screen: screen,
            padding: EdgeInsets.all(0),
          ),
        // _buttonScale(3),

      ],
    );
  }

  // Widget _buttonScale(int index) {
  //     return Center(
  //         child: Transform(
  //           transform: Matrix4.identity()..scale(1.0, 1.0),
  //           child: Stack(
  //               children: [
  //                 Container(
  //                         width: (MediaQuery.of(context).size.width < 500)
  //                             ? (MediaQuery.of(context).size.width) / 3.5
  //                             : 120,
  //                         height: (MediaQuery.of(context).size.width) / 3.5,
  //                         decoration: BoxDecoration(
  //                           color: index == 0
  //                               ? Color.fromRGBO(231, 10, 234, 0.4)
  //                               : index == 1
  //                                   ? Color.fromRGBO(10, 250, 234, 0.3)
  //                                   : Color.fromRGBO(10, 10, 250, 0.3),
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         child: ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                             backgroundColor: Colors.transparent,
  //                             shadowColor: Colors.transparent,
  //                           ),
  //                           onPressed: () {},
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: <Widget>[
  //                               iconList[index],
  //                               SizedBox(height: 5),
  //                               Text(
  //                                 '${index + 2}x${index + 2} Cube',
  //                                 style: TextStyle(fontSize: 12),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                 ]
  //                 )));
  //               }

}

// class PuzzleSelection extends StatelessWidget {
//   const PuzzleSelection({super.key});

//   @override
//   Widget build(BuildContext context) {

//   final screen = MediaQuery.of(context).size.width;
//     return Column(
//       key: const Key('puzzle_selection'),
//       children: <Widget>[
//         const SizedBox(height: 10),
//         _columnPuzzleOptions(0, screen, context),
//         _columnPuzzleOptions(3, screen, context),
//       ],
//     );
//   }

//   OverlayEntry? _overlayEntry;

//   OverlayEntry _createOverlayEntry(BuildContext context, Offset position, Size size) {
//     return OverlayEntry(
//       builder: (context) => Positioned(
//         left: position.dx,
//         top: position.dy,
//         width: size.width,
//         height: size.height,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white..withAlpha(76),
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//       ),
//     );
//   }


//   void _showOverlay(BuildContext context, Offset position, Size size) {
//     _overlayEntry = _createOverlayEntry(context, position, size);
//     Overlay.of(context)?.insert(_overlayEntry!);
//   }

//   void _removeOverlay() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }

//   Container _columnPuzzleOptions(int addingIndex, double screen, BuildContext context) {
//     return Container(
//         color: Colors.blue,
//         width: (screen < 431)
//             ? MediaQuery.of(context).size.width - 40
//             : 400,
//         height: (MediaQuery.of(context).size.height > 500) 
//           ? (MediaQuery.of(context).size.width - 80) / 3
//           : 120,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: 3,
//             itemBuilder: (context, index) {
//               Center(
//             child: Transform(
//               transform: Matrix4.identity()..scale(1.0, 1.0),
//               child: GestureDetector(
//                 onLongPressStart: (details) {
//                   RenderBox renderBox = context.findRenderObject() as RenderBox;
//                   Offset position = renderBox.localToGlobal(Offset.zero);
//                   Size size = renderBox.size;
//                   _showOverlay(context, position, size);
//                 },
//                 onLongPressEnd: (details) {
//                   _removeOverlay();
//                 },
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: (MediaQuery.of(context).size.width < 500)
//                           ? (MediaQuery.of(context).size.width) / 3.5
//                           : 120,
//                       height: (MediaQuery.of(context).size.width) / 3.5,
//                       decoration: BoxDecoration(
//                         color: index == 0
//                             ? Color.fromRGBO(231, 10, 234, 0.4)
//                             : index == 1
//                                 ? Color.fromRGBO(10, 250, 234, 0.3)
//                                 : Color.fromRGBO(10, 10, 250, 0.3),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(10),
//                           onTap: () {},
//                           splashColor: Colors.white.withOpacity(0.3),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               iconList[index],
//                               SizedBox(height: 5),
//                               Text(
//                                 '${index + 2}x${index + 2} Cube',
//                                 style: TextStyle(fontSize: 12),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//           //   return Center(
//           // child: Transform(

//           //   transform: Matrix4.identity()..scale(1.0, 1.0),
//           //   child: Stack(
//           //       children: [
//           //         Container(
//           //                 width: (MediaQuery.of(context).size.width < 500)
//           //                     ? (MediaQuery.of(context).size.width) / 3.5
//           //                     : 120,
//           //                 height: (MediaQuery.of(context).size.width) / 3.5,
//           //                 decoration: BoxDecoration(
//           //                   color: index == 0
//           //                       ? Color.fromRGBO(231, 10, 234, 0.4)
//           //                       : index == 1
//           //                           ? Color.fromRGBO(10, 250, 234, 0.3)
//           //                           : Color.fromRGBO(10, 10, 250, 0.3),
//           //                   borderRadius: BorderRadius.circular(10),
//           //                 ),
//           //                 child: ElevatedButton(
//           //                   style: ElevatedButton.styleFrom(
//           //                     backgroundColor: Colors.transparent,
//           //                     shadowColor: Colors.transparent,
//           //                   ),
//           //                   onPressed: () {},
//           //                   child: Column(
//           //                     mainAxisAlignment: MainAxisAlignment.center,
//           //                     children: <Widget>[
//           //                       iconList[index],
//           //                       SizedBox(height: 5),
//           //                       Text(
//           //                         '${index + 2}x${index + 2} Cube',
//           //                         style: TextStyle(fontSize: 12),
//           //                       ),
//           //                     ],
//           //                   ),
//           //                 ),
//           //               ),
//           //         ]
//           //         )));
//                 }
//               ),
//             );
//           }
//   }