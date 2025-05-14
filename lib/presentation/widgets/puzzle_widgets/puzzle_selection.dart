import 'package:cube_timer_2/database/models/cube_type_model.dart';
import 'package:cube_timer_2/presentation/widgets/puzzle_widgets/custom_button_splash.dart';
import 'package:flutter/material.dart';

class PuzzleSelection extends StatelessWidget {
  final List<CubeTypeModel> cubeTypes;

  const PuzzleSelection({super.key, required this.cubeTypes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 6),
      child: GridView.builder(
        key: const Key('puzzle_selection'),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          childAspectRatio: 1.35,
        ),
        padding: const EdgeInsets.all(10),
        itemCount: cubeTypes.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), // Disables scrolling
        itemBuilder: (context, index) {
          return CustomButtonSplash(
            name: cubeTypes[index].type, 
            indexPuzzleCube: index,
            padding: const EdgeInsets.symmetric(horizontal: 0),
          );
        },
      ),
    );
    
    
    
    // Row(
    //   key: const Key('puzzle_selection'),
    //   children: <Widget>[
    //     const SizedBox(height: 13),
    //     CustomButtonSplash(
    //       index: 0,
    //       padding: const EdgeInsets.symmetric(horizontal: 0),
    //     ),
    //     CustomButtonSplash(
    //       index: 1,
    //       padding: const EdgeInsets.symmetric(horizontal: 0),
    //     ),
    //     CustomButtonSplash(
    //       index: 3,
    //       padding: EdgeInsets.all(0),
    //     ),
    //     // _buttonScale(3),
    //   ],
    // );
  }
}
