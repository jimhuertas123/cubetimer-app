import 'dart:async';
import 'package:flutter/material.dart';

class CronometerTimeScreen extends StatelessWidget {
  final Timer timer;
  final double fontSize;

  const CronometerTimeScreen({
    super.key,
    required this.timer,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'cronometerTime',
            child: Text(
              "${timer.tick ~/ 1000 % 60}.${timer.tick ~/ 100 % 10}${timer.tick % 10}",
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: fontSize,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}