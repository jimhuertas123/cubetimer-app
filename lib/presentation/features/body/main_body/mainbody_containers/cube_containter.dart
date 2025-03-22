
import 'package:cube_timer_2/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CubeContainer extends StatelessWidget {
  const CubeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double containerHeight = constraints.maxHeight - 63;
            double containerWidth = constraints.maxWidth;
            return Container(
              color: Colors.transparent,
              width: containerWidth,
              child: Column(
                children: [
                  CronometerCube(
                    fontSize: containerHeight > 400 ? containerHeight*0.18 : containerHeight*0.5, 
                    containerHeight: containerHeight,
                    containerWidth: containerWidth,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}