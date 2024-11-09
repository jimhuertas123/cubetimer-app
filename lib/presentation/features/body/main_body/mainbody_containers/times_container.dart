import 'package:flutter/material.dart';

class TimesContainer extends StatelessWidget {
  const TimesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 130),
      color: const Color.fromRGBO(44, 241, 32, 0.3),
      child: const Center(
        child: Text('Times Container'),
      ),
    );
  }
}