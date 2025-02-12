import 'package:cube_timer_2/config/config.dart';
import 'package:flutter/material.dart';

/// **IOS**: animation IOS scale entire button with animation container.
///
/// **ANDROID**: animation Android only splash on long press like original material design for twisty timer.
class ButtonSplash extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  final int addingIndex;
  final double screen;
  const ButtonSplash(
      {super.key,
      required this.addingIndex,
      required this.screen,
      required this.padding});

  @override
  State<ButtonSplash> createState() => _ButtonSplashState();
}

class _ButtonSplashState extends State<ButtonSplash> {
  OverlayEntry? _overlayEntry;

  void _showOverlay(BuildContext context, Offset position, Size size) {
    _overlayEntry = _createOverlayEntry(context, position, size);
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry(
      BuildContext context, Offset position, Size size) {
    return OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx - 37.5, // Adjust to control the splash position
        top: position.dy - 37.5, // Adjust to control the splash position
        width: size.width + 75, // Adjust to control the splash size
        height: size.height + 75, // Adjust to control the splash size
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(70),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.padding,
      color: Colors.blue,
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
                  RenderBox renderBox =
                      key.currentContext!.findRenderObject() as RenderBox;
                  Offset position = renderBox.localToGlobal(Offset.zero);
                  Size size = renderBox.size;
                  _showOverlay(context, position, size);
                },
                onTapUp: (details) {
                  _removeOverlay();
                },
                onTapCancel: () {
                  _removeOverlay();
                },
                onLongPressStart: (details) {
                  RenderBox renderBox =
                      key.currentContext!.findRenderObject() as RenderBox;
                  Offset position = renderBox.localToGlobal(Offset.zero);
                  Size size = renderBox.size;
                  _showOverlay(context, position, size);
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
                        // color: index == 0
                        //     ? Color.fromRGBO(231, 10, 234, 0.4)
                        //     : index == 1
                        //         ? Color.fromRGBO(10, 250, 234, 0.3)
                        //         : Color.fromRGBO(10, 10, 250, 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {},
                          splashColor:
                              Colors.transparent, // Disable default splash
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              iconList[index],
                              SizedBox(height: 5),
                              Text(
                                '${index + 2}x${index + 2} Cube',
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
