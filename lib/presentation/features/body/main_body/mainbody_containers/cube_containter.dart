import 'package:flutter/material.dart';

class CubeContainer extends StatelessWidget {
  const CubeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 130),
      color: const Color.fromRGBO(144, 141, 232, 0.3),
      child: const Center(
        child: Text('Cube Container'),
      ),
    );
  }
}