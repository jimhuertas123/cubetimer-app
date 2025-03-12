import 'package:cube_timer_2/config/config.dart';
import 'package:cube_timer_2/presentation/providers/puzzle_options_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// **IOS**: animation IOS scale entire button with animation container (still pending).
///
/// **ANDROID**: animation Android only splash on long press like original material design for twisty timer.
class ButtonSplash extends ConsumerStatefulWidget {
  final EdgeInsetsGeometry padding;
  final int addingIndex;
  final double screen;
  // final void Function()? onTap;
  const ButtonSplash({
    super.key,
    required this.addingIndex,
    required this.screen,
    required this.padding,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ButtonSplashState();
}

class _ButtonSplashState extends ConsumerState<ButtonSplash>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isTouchDisabled = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showOverlay(BuildContext context, Offset position, Size size) {
    _removeOverlay();
    _overlayEntry = _createOverlayEntry(context, position, size);
    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
  }

  OverlayEntry _createOverlayEntry(
      BuildContext context, Offset position, Size size) {
    return OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx - 37.5, // Adjust to control the splash position
        top: position.dy - 37.5, // Adjust to control the splash position
        width: size.width + 75, // Adjust to control the splash size
        height: size.height + 75, // Adjust to control the splash size
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(30),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _animationController.reverse().then((_) {
        _overlayEntry?.remove();
        _overlayEntry = null;
        setState(() {
          _isTouchDisabled = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.padding,
      // color: Colors.blue,
      width:
          (widget.screen < 431) ? MediaQuery.of(context).size.width - 40 : 400,
      height: (MediaQuery.of(context).size.height > 500)
          ? (MediaQuery.of(context).size.width - 80) / 4
          : 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          GlobalKey key = GlobalKey();
          return Center(
            child: Transform(
              transform: Matrix4.identity()..scale(1.0, 1.0),
              child: GestureDetector(
                onTapDown: (details) {
                  if (!_isTouchDisabled) {
                    setState(() {
                      _isTouchDisabled = true;
                    });
                    RenderBox renderBox =
                        key.currentContext!.findRenderObject() as RenderBox;
                    Offset position = renderBox.localToGlobal(Offset.zero);
                    Size size = renderBox.size;
                    _showOverlay(context, position, size);
                  }
                },
                onTapUp: (details) {
                  _removeOverlay();
                },
                onTapCancel: () {
                  _removeOverlay();
                },
                onLongPressStart: (details) {
                  if (!_isTouchDisabled) {
                    setState(() {
                      _isTouchDisabled = true;
                    });
                    RenderBox renderBox =
                        key.currentContext!.findRenderObject() as RenderBox;
                    Offset position = renderBox.localToGlobal(Offset.zero);
                    Size size = renderBox.size;
                    _showOverlay(context, position, size);
                  }
                  ref.read(puzzleOptionsProvider.notifier).setPuzzleOption(
                        widget.addingIndex + index,
                      );
                  context.pop();
                },
                onLongPressEnd: (details) {
                  _removeOverlay();
                },
                child: Stack(
                  children: [
                    Container(
                      //container for every children
                      key: key,
                      width: (MediaQuery.of(context).size.width < 500)
                          ? (MediaQuery.of(context).size.width) / 3.5
                          : 133,
                      // height: (MediaQuery.of(context).size.width) / 8,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            ref.read(puzzleOptionsProvider.notifier).setPuzzleOption(
                              widget.addingIndex + index,
                            );
                            context.pop();
                          },
                          splashColor: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              iconList[widget.addingIndex + index],
                              SizedBox(height: 5),
                              Text(
                                '${widget.addingIndex + index + 2}x${widget.addingIndex + index + 2} Cube',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// **IOS**: animation IOS scale entire button with animation container (still pending).
///
/// **ANDROID**: animation Android only splash on long press like original material design for twisty timer.
// class ButtonSplash extends StatefulWidget {
//   final EdgeInsetsGeometry padding;
//   final int addingIndex;
//   final double screen;
//   // final void Function()? onTap;
//   const ButtonSplash(
//       {super.key,
//       required this.addingIndex,
//       required this.screen,
//       required this.padding,
//     });

//   @override
//   State<ButtonSplash> createState() => _ButtonSplashState();
// }

// class _ButtonSplashState extends State<ButtonSplash>
//     with SingleTickerProviderStateMixin {
//   OverlayEntry? _overlayEntry;
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//   bool _isTouchDisabled = false;

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 200),
//       reverseDuration: const Duration(milliseconds: 200),
//       vsync: this,
//     );
//     _scaleAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//   }

//   @override
//   dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _showOverlay(BuildContext context, Offset position, Size size) {
//     _removeOverlay();
//     _overlayEntry = _createOverlayEntry(context, position, size);
//     Overlay.of(context).insert(_overlayEntry!);
//     _animationController.forward();
//   }

//   OverlayEntry _createOverlayEntry(
//       BuildContext context, Offset position, Size size) {
//     return OverlayEntry(
//       builder: (context) => Positioned(
//         left: position.dx - 37.5, // Adjust to control the splash position
//         top: position.dy - 37.5, // Adjust to control the splash position
//         width: size.width + 75, // Adjust to control the splash size
//         height: size.height + 75, // Adjust to control the splash size
//         child: ScaleTransition(
//           scale: _scaleAnimation,
//           child: Material(
//             color: Colors.transparent,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.black.withAlpha(30),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _removeOverlay() {
//     if (_overlayEntry != null) {
//       _animationController.reverse().then((_) {
//         _overlayEntry?.remove();
//         _overlayEntry = null;
//         setState(() {
//           _isTouchDisabled = false;
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: widget.padding,
//       // color: Colors.blue,
//       width:
//           (widget.screen < 431) ? MediaQuery.of(context).size.width - 40 : 400,
//       height: (MediaQuery.of(context).size.height > 500)
//           ? (MediaQuery.of(context).size.width - 80) / 4
//           : 120,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 3,
//         itemBuilder: (context, index) {
//           GlobalKey key = GlobalKey();
//           return Center(
//             child: Transform(
//               transform: Matrix4.identity()..scale(1.0, 1.0),
//               child: GestureDetector(
//                 onTapDown: (details) {
//                   if (!_isTouchDisabled) {
//                     setState(() {
//                       _isTouchDisabled = true;
//                     });
//                     RenderBox renderBox =
//                         key.currentContext!.findRenderObject() as RenderBox;
//                     Offset position = renderBox.localToGlobal(Offset.zero);
//                     Size size = renderBox.size;
//                     _showOverlay(context, position, size);
//                   }
//                 },
//                 onTapUp: (details) {
//                   _removeOverlay();
//                 },
//                 onTapCancel: () {
//                   _removeOverlay();
//                 },
//                 onLongPressStart: (details) {
//                   if (!_isTouchDisabled) {
//                     setState(() {
//                       _isTouchDisabled = true;
//                     });
//                     RenderBox renderBox =
//                         key.currentContext!.findRenderObject() as RenderBox;
//                     Offset position = renderBox.localToGlobal(Offset.zero);
//                     Size size = renderBox.size;
//                     _showOverlay(context, position, size);
//                   }
//                 },
//                 onLongPressEnd: (details) {
//                   _removeOverlay();
//                 },
//                 onTap: () => {
//                   debugPrint('Button tapped!'),
//                 },
//                 child: Stack(
//                   children: [
//                     Container(
//                       //container for every children
//                       key: key,
//                       width: (MediaQuery.of(context).size.width < 500)
//                           ? (MediaQuery.of(context).size.width) / 3.5
//                           : 133,
//                       // height: (MediaQuery.of(context).size.width) / 8,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           highlightColor: Colors.transparent,
//                           borderRadius: BorderRadius.circular(10),
//                           onTap: () {},
//                           splashColor: Colors.transparent,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               iconList[widget.addingIndex + index],
//                               SizedBox(height: 5),
//                               Text(
//                                 '${widget.addingIndex + index + 2}x${widget.addingIndex + index + 2} Cube',
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
//         },
//       ),
//     );
//   }
// }
