import 'dart:async';

import 'package:cube_timer_2/presentation/providers/cronometer_runner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CronometerCube extends ConsumerStatefulWidget {
  final double fontSize;
  final double containerHeight;
  final double containerWidth;

  const CronometerCube(
      {super.key,
      required this.fontSize,
      required this.containerHeight,
      required this.containerWidth});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CronometerCubeState();
}

class _CronometerCubeState extends ConsumerState<CronometerCube>
    with SingleTickerProviderStateMixin {
  Timer _timer = Timer(Duration(seconds: 0), () {});
  int minutes = 0;
  int seconds = 0;
  int milliseconds = 0;
  int macroseconds = 0;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimationScramble;
  late Animation<Offset> _slideAnimationResults;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  void startTimer(bool isRunning) {
    debugPrint("startTimer");
    if (isRunning) {
      setState(() {
        isRunning = false;
        _timer.cancel();
        _animationController.reverse();
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
    _animationController.forward();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimationScramble = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimationResults = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    ));
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isRunning = ref.watch(cronometerRunnerProvider);

    return Expanded(
      child: GestureDetector(
        onTap: () => {
          ref
              .read(cronometerRunnerProvider.notifier)
              .isTimerRunning(!isRunning),
          debugPrint("isRunning: $isRunning"),
          startTimer(isRunning)
        },
        child: Container(
          color: Colors.blue,
          child: Center(
            child: Column(children: [
              //SCRAMBLE
              SlideTransition(
                position: _slideAnimationScramble,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: double.infinity,
                    height: widget.containerHeight > 400
                        ? widget.containerHeight * 15 / 100
                        : widget.containerHeight * 20 / 100,
                    color: Color.fromRGBO(100, 100, 100, 0.3),
                    child: Text('Container Height: ${widget.containerHeight}'),
                  ),
                ),
              ),

              //CRONOMETER
              Expanded(
                child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: CronometerTime(timer: _timer, widget: widget)),
              ),

              //RESULTS
              SlideTransition(
                position: _slideAnimationResults,
                child: FadeTransition(
                    opacity: _fadeAnimation, child: CronometerResults()),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

///CRONOMETER RESULTS
///Widget that shows the results of the cronometer like average of 5, 12, 50 and 100 and best, mean and count
class CronometerResults extends StatefulWidget {
  const CronometerResults({
    super.key,
  });

  @override
  State<CronometerResults> createState() => _CronometerResultsState();
}

class _CronometerResultsState extends State<CronometerResults> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        height: 87,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(children: <Widget>[
                Text(
                  '''
                  Deviation: --,
                  Mean: 6.15
                  Best: 6.15
                  Count: 1''',
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.rtl,
                ),
              ]),
              Column(children: <Widget>[
                Text(
                  '''
                  Ao5: 2.45.2
                  Ao12: 2.45.2
                  Ao50: 2.45.2
                  Ao100: 2.45.2''',
                  textAlign: TextAlign.end,
                ),
              ]),
            ]));
  }
}

class CronometerTime extends StatelessWidget {
  const CronometerTime({
    super.key,
    required Timer timer,
    required this.widget,
  }) : _timer = timer;

  final Timer _timer;
  final CronometerCube widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
            )),
        Text(
          _timer.tick > 60000
              ? _timer.tick < 70000
                  ? "0${_timer.tick ~/ 1000 % 60}"
                  : "${_timer.tick ~/ 1000 % 60}"
              : "${_timer.tick ~/ 1000 % 60}",
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
          ".${_timer.tick ~/ 100 % 10}${_timer.tick % 10}",
          style: TextStyle(
              fontFamily: 'Lato',
              fontSize: widget.fontSize * 0.75,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              height: 0.9),
        )
      ],
    );
  }
}
