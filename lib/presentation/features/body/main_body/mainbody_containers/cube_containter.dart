
import 'package:cube_timer_2/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CubeContainer extends StatelessWidget {
  const CubeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    const double spaceFromTop = 130.0;
    const double spaceFromBottom = 42.0;
    return Builder(
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double containerHeight = constraints.maxHeight - spaceFromTop - spaceFromBottom;
            double containerWidth = constraints.maxWidth;

            return Container(
              margin: EdgeInsets.only(
                top: containerHeight > 400 ? spaceFromTop : spaceFromTop - 63, 
                bottom: spaceFromBottom),
              color: Colors.white,
              height: containerHeight,
              width: containerWidth,
              child: Column(
                children: [
                  CronometerCube(
                    fontSize: containerHeight > 400 ? containerHeight*0.16 : containerHeight*0.35, 
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