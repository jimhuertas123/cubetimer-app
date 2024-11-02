import 'package:cube_timer_2/config/config.dart';
import 'package:cube_timer_2/presentation/features/body_contents/listview_container.dart';

import 'package:flutter/material.dart';

class BodyContent extends StatefulWidget {
  final PageController pageController;
  final ColorPair patternColor;
  const BodyContent(
      {super.key,
      required this.patternColor,
      required this.pageController,
  });

  @override
  State<BodyContent> createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent>
    with SingleTickerProviderStateMixin {
  double stretchFactor = 1.0;
  late AnimationController _controller;
  late Animation<double> _stretchAnimation;
  bool isAtEdge = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _stretchAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is OverscrollNotification && !isAtEdge) {
          // Activa la animación de estiramiento solo si no está en el borde
          isAtEdge = true;
          _controller.forward(from: 0.0);
        } else if (notification is ScrollEndNotification) {
          // Cuando termina el desplazamiento, resetea el borde y la animación
          isAtEdge = false;
          _controller.reverse();
        }
        return true;
      },
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.patternColor.primaryColor,
                widget.patternColor.secondaryColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: PageViewContainers(
            pageController: widget.pageController,
            stretchAnimation: _stretchAnimation,
          )),
    );
  }
}
