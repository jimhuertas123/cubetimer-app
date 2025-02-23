import 'dart:async';

import 'package:flutter/material.dart';

class CronometerCube extends StatefulWidget {
  final double fontSize;
  const CronometerCube({super.key, required this.fontSize});

  @override
  State<CronometerCube> createState() => _CronometerCubeState();
}

class _CronometerCubeState extends State<CronometerCube> {
  Timer _timer = Timer(Duration(seconds: 0), () {});

  int minutes = 0;
  int seconds = 0;
  int milliseconds = 0;
  int macroseconds = 0;
  bool isRunning = false;

  void startTimer() {
    debugPrint("startTimer");
    if (isRunning) {
      setState(() {
        isRunning = false;
        _timer.cancel();
      });
      return;
    }
    isRunning = true;
    seconds = 0;
    const oneSec = Duration(milliseconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          milliseconds = (timer.tick % 1000) ~/ 10;
          seconds = (timer.tick ~/ 1000) % 60;
          minutes = (timer.tick ~/ 60000) % 60;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => startTimer(),
        child: Container(
          color: Colors.blue,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: _timer.tick > 60000,
                  child: Text(
                    "1:",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: widget.fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 0.9,
                    ),
                  )
                ),
                Text(
                  _timer.tick > 60000 
                    ? "${_timer.tick~/1000%60}"
                    : "${_timer.tick~/1000%60}",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: widget.fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 0.9,
                  ),
                  textAlign: TextAlign.end,
                ),
                Text(
                  ".${_timer.tick~/100%10}${_timer.tick%10}",
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: widget.fontSize * 0.75,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 0.9),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
