import 'package:cube_timer_2/config/config.dart';
import 'package:cube_timer_2/presentation/providers/puzzle_options_provider.dart';
import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../config/puzzle_options/puzzle_options_enum.dart';

/// **IOS**: animation IOS scale entire button with animation container (still pending).
///
/// **ANDROID**: animation Android only splash on long press like original material design for twisty timer.
class CustomButtonSplash extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final int addingIndex;

  const CustomButtonSplash(
      {super.key, required this.addingIndex, required this.padding});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return IOSButtonSplashRow(
        addingIndex: addingIndex,
      );
    } else {
      return AndroidButtonSplashRow(
        addingIndex: addingIndex,
        padding: padding,
      );
    }
  }
}

/// **IOS**: animation IOS scale entire button with animation container (still pending).
/// didnt exist original animation, but agree making it like long press animation in ios
/// splash oversize scaling the entire button.
class IOSButtonSplashRow extends ConsumerStatefulWidget {
  final int addingIndex;
  const IOSButtonSplashRow({
    super.key,
    required this.addingIndex,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IOSButtonSplashRowState();
}

class _IOSButtonSplashRowState extends ConsumerState<IOSButtonSplashRow>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final AnimationController _scaleController;
  int? _activeIndex; // Índice del botón que se está animando

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _startAnimation(int index) {
    setState(() => _activeIndex = index);
    _scaleController.forward();
    _controller.repeat(reverse: true);
  }

  void _stopAnimation() {
    setState(() => _activeIndex = null);
    _controller.stop();
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    final actualPuzzleOption = ref.watch(puzzleOptionsProvider).puzzleOption;

    return SizedBox(
      width: (screen < 431) ? MediaQuery.of(context).size.width - 40 : 400,
      height: (MediaQuery.of(context).size.height > 500)
          ? (MediaQuery.of(context).size.width - 80) / 4
          : 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          final isActive = _activeIndex == index;

          return Center(
            child: GestureDetector(
              onTap: () {
                CubeType optionWanted = CubeType.values[widget.addingIndex + index];
                if (optionWanted != actualPuzzleOption) {
                  ref.read(puzzleOptionsProvider.notifier).setPuzzleOption(
                    widget.addingIndex + index,
                  );
                }
                context.pop();
              },
              onLongPressStart: (_) {
                _startAnimation(index);
              },
              onLongPressEnd: (_) {
                _stopAnimation();
                CubeType optionWanted = CubeType.values[widget.addingIndex + index];
                if (optionWanted != actualPuzzleOption) {
                  ref.read(puzzleOptionsProvider.notifier).setPuzzleOption(
                    widget.addingIndex + index,
                  );
                }
                context.pop();
              },
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateZ(isActive ? _animation.value : 0.0),
                    child: ScaleTransition(
                      scale: isActive
                          ? Tween<double>(begin: 1.0, end: 1.2).animate(
                              CurvedAnimation(
                                parent: _scaleController,
                                curve: Curves.easeInOut,
                              ),
                            )
                          : const AlwaysStoppedAnimation(1.0),
                      child: Container(
                        width: (screen < 500) ? screen / 3.5 : 133,
                        height: 50,
                        decoration: BoxDecoration(
                          // color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            iconList[widget.addingIndex + index],
                            const SizedBox(height: 5),
                            Text(
                              '${widget.addingIndex + index + 2}x${widget.addingIndex + index + 2} Cube',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

/// **ANDROID**: animation Android only splash on long press like original material design for twisty timer.
/// splash oversize container size like original twisty timer app.
class AndroidButtonSplashRow extends ConsumerStatefulWidget {
  final EdgeInsetsGeometry padding;
  final int addingIndex;
  // final void Function()? onTap;
  const AndroidButtonSplashRow({
    super.key,
    required this.addingIndex,
    required this.padding,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AndroidButtonSplashRowState();
}

class _AndroidButtonSplashRowState extends ConsumerState<AndroidButtonSplashRow>
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

  Future<void> _removeOverlay() async {
    if (_overlayEntry != null) {
      await _animationController.reverse().then((_) {
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
    final screen = MediaQuery.of(context).size.width;
    final actualPuzzleOption = ref.watch(puzzleOptionsProvider).puzzleOption;

    return Container(
      margin: widget.padding,
      width: (screen < 431) ? MediaQuery.of(context).size.width - 40 : 400,
      height: (MediaQuery.of(context).size.height > 500)
          ? (MediaQuery.of(context).size.width - 80) / 4
          : 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          GlobalKey key = GlobalKey();
          return Center(
            child: GestureDetector(
              onTap: () async {
                CubeType optionWanted =
                    CubeType.values[widget.addingIndex + index];
                if (optionWanted != actualPuzzleOption) {
                  await _removeOverlay();
                  ref
                      .read(puzzleOptionsProvider.notifier)
                      .setPuzzleOption(
                        widget.addingIndex + index,
                      );
                }
                if (mounted) context.pop();
                
              },
              onLongPressStart: (details) async {
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
              onLongPressEnd: (details) async {
                _removeOverlay();
                CubeType optionWanted =
                    CubeType.values[widget.addingIndex + index];
                if (optionWanted != actualPuzzleOption) {
                  await _removeOverlay();
                  if (mounted) {
                    ref.read(puzzleOptionsProvider.notifier).setPuzzleOption(
                          widget.addingIndex + index,
                        );
                    context.pop();
                  }
                }
              },
              child: Container(
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
          );
        },
      ),
    );
  }
}
