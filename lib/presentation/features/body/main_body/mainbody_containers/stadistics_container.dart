import 'package:flutter/material.dart';

class StadiscticsContainer extends StatelessWidget {
  const StadiscticsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 130),
      color: const Color.fromRGBO(244, 241, 232, 0.2),
      child: const Center(
        child: Text('Stadistics Container'),
      ),
    );
  }
}