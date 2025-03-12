import 'package:cube_timer_2/presentation/widgets/puzzle_widgets/button_splash.dart';
import 'package:flutter/material.dart';

class PuzzleSelection extends StatelessWidget {
  const PuzzleSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    

    return Column(
      key: const Key('puzzle_selection'),
      children: <Widget>[
        const SizedBox(height: 13),
        ButtonSplash(
          addingIndex: 0,
          screen: screen,
          padding: const EdgeInsets.symmetric(horizontal: 0),
        ),
        ButtonSplash(
          addingIndex: 3,
          screen: screen,
          padding: EdgeInsets.all(0),
        ),
        // _buttonScale(3),
      ],
    );
  }
}
