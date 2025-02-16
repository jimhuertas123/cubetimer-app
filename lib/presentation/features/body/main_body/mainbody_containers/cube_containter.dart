import 'package:flutter/material.dart';

class CubeContainer extends StatelessWidget {
  const CubeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    const double spaceFromTop = 130.0;
    const double spaceFromBottom = 55.0;
    return Builder(
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double containerHeight = constraints.maxHeight - spaceFromTop - spaceFromBottom;
            double containerWidth = constraints.maxWidth;

            return Container(
              margin: const EdgeInsets.only(top: 130, bottom: 55),
              color: Colors.white,
              height: containerHeight,
              width: containerWidth,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: containerHeight*15/100,
                    color: Color.fromRGBO(100, 100, 100, 0.3),
                    child: Text('Container Height: $containerHeight')
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                      child: Text('Container Height: $containerHeight'),
                    )
                  ),
                  Container(
                    width: double.infinity,
                    height: containerHeight*70/100,
                    color: Colors.red,
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('Ao5: 2.45.2'),
                            Text('Ao12: 123'),
                            Text('Ao50: 12.3'),
                            Text('Ao100: 12.00'),
                          ]
                        ),
                        Column(
                          children: <Widget>[
                            Text('Ao5: 2.45.2'),
                            Text('Ao12: 123'),
                            Text('Ao50: 12.3'),
                            Text('Ao100: 12.00'),
                          ]
                        )
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