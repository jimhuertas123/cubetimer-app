import 'package:cube_timer_2/presentation/widgets/puzzle_widgets/button_splash.dart';
import 'package:flutter/material.dart';

class PuzzleSelection extends StatelessWidget {
  const PuzzleSelection({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      key: const Key('puzzle_selection'),
      children: <Widget>[
        const SizedBox(height: 13),
        CustomButtonSplash(
          addingIndex: 0,
          padding: const EdgeInsets.symmetric(horizontal: 0),
        ),
        CustomButtonSplash(
          addingIndex: 3,
          padding: EdgeInsets.all(0),
        ),
        // _buttonScale(3),
      ],
    );
  }
}
