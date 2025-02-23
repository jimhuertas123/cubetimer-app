
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
                  Container(
                    width: double.infinity,
                    height: containerHeight > 400 ? containerHeight*15/100 : containerHeight*20/100,
                    color: Color.fromRGBO(100, 100, 100, 0.3),
                    child: Text('Container Height: $containerHeight')
                  ),
                  CronometerCube(
                    fontSize: containerHeight > 400 ? containerHeight*0.16 : containerHeight*0.35, 
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: double.infinity,
                    height: 87,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('''
                              Deviation: --,
                              Mean: 6.15
                              Best: 6.15
                              Count: 1''',
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.rtl,
                            ),
                          ]
                        ),
                        Column(
                          children: <Widget>[
                            Text('''
                              Ao5: 2.45.2
                              Ao12: 2.45.2
                              Ao50: 2.45.2
                              Ao100: 2.45.2''',
                              textAlign: TextAlign.end,
                            ),
                          ]
                        ),
                      ]
                    )
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