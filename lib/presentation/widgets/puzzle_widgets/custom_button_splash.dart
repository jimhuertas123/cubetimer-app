import 'package:cube_timer_2/config/config.dart';
import 'package:cube_timer_2/config/database/config_database.dart';
import 'package:cube_timer_2/database/models/cube_type_model.dart';
import 'package:cube_timer_2/presentation/providers/cube_type_provider.dart';
import 'package:cube_timer_2/presentation/providers/puzzle_options_provider.dart';
import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

/// **IOS**: animation IOS scale entire button with animation container (still pending).
///
/// **ANDROID**: animation Android only splash on long press like original material design for twisty timer.
class CustomButtonSplash extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final CubeType name;
  final int index;

  const CustomButtonSplash(
      {super.key, required this.index, required this.padding, required this.name});

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return IOSButtonSplashRow(
        name: name.name,
        index: index,
      );
    } else {
      return AndroidButtonSplashRow(
        name: name.name,
        index: index,
        padding: padding,
      );
    }
  }
}

/// **IOS**: animation IOS scale entire button with animation container (still pending).
/// didnt exist original animation, but agree making it like long press animation in ios
/// splash oversize scaling the entire button.
class IOSButtonSplashRow extends ConsumerStatefulWidget {
  final int index;
  final String name;
  const IOSButtonSplashRow({
    super.key,
    required this.name,
    required this.index,
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
  bool isActive = false;

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
    setState(() => isActive = true);
    _scaleController.forward();
    _controller.repeat(reverse: true);
  }

  void _stopAnimation() {
    setState(() => isActive = false);
    _controller.stop();
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    final actualPuzzleOption = ref.watch(cubeTypeProvider).actualCubeType.type;

    return Container(
      padding: widget.index > 2 ? EdgeInsets.only(top: 15) : EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          CubeType optionWanted = CubeType.values[widget.index];
          if (optionWanted != actualPuzzleOption) {
            CubeTypeModel cubeTypeModel =
                CubeTypeModel(id: widget.index, type: optionWanted);
            ref
                .read(cubeTypeProvider.notifier)
                .setCurrentCubeType(cubeTypeModel);
            context.pop();
          }
        },
        onLongPressStart: (_) {
          _startAnimation(widget.index);
        },
        onLongPressEnd: (_) {
          isActive = false;
          _stopAnimation();
          CubeType optionWanted = CubeType.values[widget.index];
          if (optionWanted != actualPuzzleOption) {
            ref
                .read(puzzleOptionsProvider.notifier)
                .setPuzzleOption(widget.index);
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
                      iconList[widget.index],
                      const SizedBox(height: 5),
                      Text(
                        '${widget.name} Cube',
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
  }
}

/// **ANDROID**: animation Android only splash on long press like original material design for twisty timer.
/// splash oversize container size like original twisty timer app.
class AndroidButtonSplashRow extends ConsumerStatefulWidget {
  final EdgeInsetsGeometry padding;
  final int index;
  final String name;  
  const AndroidButtonSplashRow({
    super.key,
    required this.name,
    required this.index,
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
    _overlayEntry = _createOverlayEntry(context, position, size);
    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
  }

  OverlayEntry _createOverlayEntry(
      BuildContext context, Offset position, Size size) {
    return OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx - 22, // Adjust to control the splash position
        top: position.dy - 22, // Adjust to control the splash position
        width: size.width + 44, // Adjust to control the splash size
        height: size.height + 44, // Adjust to control the splash size
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(10),
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

  final GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final actualPuzzleOption = ref.watch(puzzleOptionsProvider).puzzleOption;

    return Container(
      key: key,
      margin: widget.padding,
      child: GestureDetector(
        onTap: () async {
          CubeType optionWanted = CubeType.values[widget.index];
          if (optionWanted != actualPuzzleOption) {
            await _removeOverlay();
            ref
                .read(puzzleOptionsProvider.notifier)
                .setPuzzleOption(widget.index);
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
          CubeType optionWanted = CubeType.values[widget.index];
          if (optionWanted != actualPuzzleOption) {
            await _removeOverlay();
            if (mounted) {
              ref
                  .read(puzzleOptionsProvider.notifier)
                  .setPuzzleOption(widget.index);
              context.pop();
            }
          }
        },
        child: Container(
          //container for every children
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
              iconList[widget.index],
              SizedBox(height: 5),
              Text(
                '${widget.name} Cube',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
