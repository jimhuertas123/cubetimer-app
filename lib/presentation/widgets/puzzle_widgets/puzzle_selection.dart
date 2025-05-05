import 'package:cube_timer_2/database/models/cube_type_model.dart';
import 'package:cube_timer_2/presentation/widgets/puzzle_widgets/custom_button_splash.dart';
import 'package:flutter/material.dart';

class PuzzleSelection extends StatelessWidget {
  final List<CubeTypeModel> cubeTypes;

  const PuzzleSelection({super.key, required this.cubeTypes});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('puzzle_selection'),
      children: <Widget>[
        const SizedBox(height: 13),
        // cubeTypes.isNotEmpty
        //     ? Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: cubeTypes
        //             .map((cubeType) => CustomButtonSplash(
        //                   addingIndex: cubeTypes.indexOf(cubeType),
        //                   padding: const EdgeInsets.symmetric(horizontal: 0),
        //                 ))
        //             .toList(),
        //       )
        //     : const SizedBox.shrink(),
        
    
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
