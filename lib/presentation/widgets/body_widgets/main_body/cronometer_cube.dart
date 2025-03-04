import 'dart:async';
import 'package:cube_timer_2/presentation/providers/cronometer_runner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/config.dart';
import '../../../providers/providers.dart';

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
    double scrambleHeight = widget.containerHeight > 300
        ? widget.containerHeight * 12 / 100
        : widget.containerHeight * 20 / 100;
    double cronometerHeight = widget.containerHeight > 400 
      ? widget.containerHeight - scrambleHeight - 87 - 213
      : widget.containerHeight - scrambleHeight - 87 - 110;
    final int actualTextColorIndex = ref.watch(themeNotifierProvider).actualTextThemeIndex;
    final bool isDarkMode = ref.watch(themeNotifierProvider).isDarkmode;
    final colorTextTheme = (actualTextColorIndex == 0)
      ? (isDarkMode)
          ? Colors.black
          : Colors.white
      : appTextTheme[actualTextColorIndex].colorText;

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
            color: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Extra space instead of using padding or margin that makes it loosing touching detection
                  Container(
                    height: widget.containerHeight > 400 
                    ? 145
                    : 75
                  ),

                  //SCRAMBLE
                  SlideTransition(
                    position: _slideAnimationScramble,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScrambleInfo(
                        scrambleHeight: scrambleHeight, 
                        widget: widget,
                        colorTextTheme: colorTextTheme
                      ),
                    ),
                  ),
                    
                  //CRONOMETER
                  ScaleTransition(
                        scale: _scaleAnimation,
                        child: CronometerTime(
                          textColor: colorTextTheme,
                          isTimerRunning: isRunning,
                          timer: _timer,
                          height: widget.containerHeight > 300 
                            ? cronometerHeight + 60
                            : cronometerHeight,
                          fontSize: widget.fontSize
                        )),
                    
                  //RESULTS
                  SlideTransition(
                    position: _slideAnimationResults,
                    child: FadeTransition(
                      opacity: _fadeAnimation, 
                      child: CronometerResults(
                        textColor: colorTextTheme
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ),
      ),
    );
  }
}

class ScrambleInfo extends StatelessWidget {
  const ScrambleInfo({
    super.key,
    required this.scrambleHeight,
    required this.widget,
    required this.colorTextTheme,
  });

  final double scrambleHeight;
  final CronometerCube widget;
  final Color colorTextTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: scrambleHeight,
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'U2 L\' D R2 B\' L2 B2 D2 R2 U\' B2 U\' R2 U\' B2 R2 B\' U: ${widget.containerHeight}',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 23,
                height: 1,
                color: colorTextTheme,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    CupertinoIcons.lightbulb,
                    // Icons.wb_incandescent_outlined,
                    color: colorTextTheme,
                    size: 25,
                  ),
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.pencil,
                        // Icons.edit_outlined,
                        color: colorTextTheme,
                        size: 25,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        // Icons.autorenew,
                        CupertinoIcons.arrow_2_circlepath,
                        color: colorTextTheme,
                        size: 25,
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}

///CRONOMETER RESULTS
///Widget that shows the results of the cronometer like average of 5, 12, 50 and 100 and best, mean and count
class CronometerResults extends StatefulWidget {
  final Color textColor;
  const CronometerResults({
    required this.textColor,
    super.key,
  });

  @override
  State<CronometerResults> createState() => _CronometerResultsState();
}

class _CronometerResultsState extends State<CronometerResults> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
        color: Colors.transparent,
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        height: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 1,
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: widget.textColor,
                  width: 1.5,
                ),
              ),
              child: Text(
                "¡New Average Best!",
                style: TextStyle(
                  color: widget.textColor,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                  Text(
                    '''
                  Deviation: --,
                  Mean: 6.15
                  Best: 6.15
                  Count: 1''',
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: widget.textColor
                    ),
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
                    style: TextStyle(
                      color: widget.textColor
                    ),
                  ),
                ]),
              ]),
            ]
        ));
  }
}

class CronometerTime extends StatelessWidget {
  const CronometerTime({
    super.key,
    required this.textColor,
    required this.height,
    required Timer timer,
    required this.isTimerRunning, 
    required this.fontSize,
  }) : _timer = timer;

  final Timer _timer;
  final double height;
  final double fontSize;
  final bool isTimerRunning;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("Congratulations! You've just beaten your previous personal  best by 12.23",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: textColor,
              ),
            ),
          ),
          SizedBox(
            height: height*0.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                  visible: _timer.tick > 60000,
                  child: Text(
                    "1:",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: fontSize,
                      color: textColor,
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
                  fontSize: fontSize,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  height: 0.9,
                ),
                textAlign: TextAlign.end,
              ),
              Text(
                ".${_timer.tick ~/ 100 % 10}${_timer.tick % 10}",
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: fontSize * 0.75,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    height: 0.9),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  CupertinoIcons.xmark,
                  // Icons.edit_outlined,
                  color: textColor,
                  size: 25,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  // Icons.autorenew,
                  CupertinoIcons.slash_circle,
                  color: textColor,
                  size: 25,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  // Icons.autorenew,
                  CupertinoIcons.flag,
                  color: textColor,
                  size: 25,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  // Icons.autorenew,
                  CupertinoIcons.text_bubble,
                  color: textColor,
                  size: 25,
                ),
                onPressed: () {},
              ),
            ],
          )
        ]
      ),
    );
  }
}
