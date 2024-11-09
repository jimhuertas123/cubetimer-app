import 'package:cube_timer_2/config/config.dart';
import 'package:cube_timer_2/presentation/features/features.dart';
import 'package:cube_timer_2/presentation/widgets/body_widgets/listview_container.dart';

import 'package:flutter/material.dart';

class MainBody extends StatefulWidget {
   // 0 for main body, 1 for oll training body, 2 for pll training body
  final int optionBody;

  final PageController pageController;
  final ColorPair patternColor;
  const MainBody({
    super.key,
    required this.patternColor,
    required this.pageController,
    required this.optionBody
  })  : assert(optionBody >= 0 && optionBody <= 2);

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody>
    with SingleTickerProviderStateMixin {
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
    _stretchAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
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
    debugPrint("mainbody build");

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
            key: const Key('main_body'),
            pages: const [
              CubeContainer(),
              TimesContainer(),
              StadiscticsContainer()
            ],
            pageController: widget.pageController,
            stretchAnimation: _stretchAnimation,
          )),
    );
  }
}
