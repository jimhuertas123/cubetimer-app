import 'dart:async';
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
    with TickerProviderStateMixin {
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
  late Animation<double> _circleScaleAnimation;
  late Animation<double> _circleOpacityAnimation;
  late Animation<double> _buttonScaleAnimation;
  late AnimationController _animationTimeBrokedController;

  void startTimer(bool isRunning) {
    debugPrint("startTimer");
    if (isRunning) {
      setState(() {
        isRunning = false;
        _timer.cancel();
        _animationController.reverse();
        _animationTimeBrokedController.forward();
        // _animationTimeBrokedController.reverse();
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
    _animationTimeBrokedController.reverse();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animationTimeBrokedController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      reverseDuration: const Duration(milliseconds: 0),
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

    _circleScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 5.0,
    ).animate(CurvedAnimation(
      parent: _animationTimeBrokedController,
      curve: Curves.easeInOut,
    ));

    _circleOpacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationTimeBrokedController,
      curve: Curves.easeInOut,
    ));

    _buttonScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    _animationTimeBrokedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool brokedNewRecord = ref.watch(cronometerRunnerProvider).breakNewRecord;
    bool isRunning = ref.watch(cronometerRunnerProvider).isRunning;
    double scrambleHeight = widget.containerHeight > 300
        ? widget.containerHeight * 12 / 100
        : widget.containerHeight * 20 / 100;
    double cronometerHeight = widget.containerHeight > 400
        ? widget.containerHeight - scrambleHeight - 87 - 213
        : widget.containerHeight - scrambleHeight - 87 - 110;
    final int actualTextColorIndex =
        ref.watch(themeNotifierProvider).actualTextThemeIndex;
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
                ref
                    .read(cronometerRunnerProvider.notifier)
                    .breakedNewRecord(true),
                debugPrint("isRunning: $isRunning"),
                startTimer(isRunning)
              },
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              color: Colors.transparent,
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: _circleScaleAnimation,
                    builder: (context, child) {
                      return Visibility(
                        visible: !isRunning && brokedNewRecord,
                        child: Center(
                          child: Transform.scale(
                            scale: _circleScaleAnimation.value,
                            child: Opacity(
                              opacity: _circleOpacityAnimation.value,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                                    
                        //SCRAMBLE
                        SlideTransition(
                          position: _slideAnimationScramble,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: ScrambleInfo(
                                containerHeight: widget.containerHeight,
                                scrambleHeight: scrambleHeight,
                                widget: widget,
                                colorTextTheme: colorTextTheme),
                          ),
                        ),
              
                        //CRONOMETER
                        CronometerTime(
                            scaleAnimation: _scaleAnimation,
                            buttonScaleAnimation: _buttonScaleAnimation,
                            textColor: colorTextTheme,
                            isTimerRunning: isRunning,
                            breakNewRecord: brokedNewRecord,
                            containerHeight: widget.containerHeight,
                            timer: _timer,
                            height: cronometerHeight,
                            fontSize: widget.containerHeight > 400
                              ? widget.fontSize
                              : widget.fontSize * 0.6),
              
                        //RESULTS
                        SlideTransition(
                          position: _slideAnimationResults,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: CronometerResults(
                                buttonScaleAnimation: _buttonScaleAnimation,
                                isRunning: isRunning,
                                breakNewRecord: brokedNewRecord,
                                textColor: colorTextTheme),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 3,
                    bottom: 80,
                    child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 1,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: !isRunning && brokedNewRecord
                            ? colorTextTheme
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      !isRunning && brokedNewRecord
                          ? "¡New Average Best!"
                          : "",
                      style: TextStyle(
                        color: colorTextTheme,
                        fontSize: 11
                      ),
                    ),
                  ), 
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class ScrambleInfo extends StatelessWidget {
  const ScrambleInfo({
    super.key,
    required this.scrambleHeight,
    required this.widget,
    required this.colorTextTheme,
    required this.containerHeight,
  });

  final double containerHeight;
  final double scrambleHeight;
  final CronometerCube widget;
  final Color colorTextTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: scrambleHeight,
      child: containerHeight > 400
          ? Column(
              children: _scrambleInfoColumn(colorTextTheme: colorTextTheme),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _scrambleInfoRow(colorTextTheme: colorTextTheme),
            ),
    );
  }
}

List<Widget> _scrambleInfoColumn({
  required Color colorTextTheme,
  }) => [
  Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      'U2 L\' D R2 B\' L2 B2 D2 R2 U\' B2 U\' R2 U\' B2 R2 B\' U',
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 18,
        height: 1,
        color: colorTextTheme,
      ),
    ),
  ),
Container(
  margin: const EdgeInsets.symmetric(horizontal: 10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ///None hint funcionality added yet, TODO: future hint for crosses on 3x3 cube
      // IconButton(
      //   icon: Icon(
      //     CupertinoIcons.lightbulb,
      //     // Icons.wb_incandescent_outlined,
      //     color: colorTextTheme,
      //     size: 25,
      //   ),
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      // ),
      Row(
        children: [
          IconButton(
            icon: Icon(
              CupertinoIcons.pencil,
              // Icons.edit_outlined,
              color: colorTextTheme,
              size: 20,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              // Icons.autorenew,
              CupertinoIcons.arrow_2_circlepath,
              color: colorTextTheme,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      )
    ],
  ),
)
];

List<Widget> _scrambleInfoRow({
  required Color colorTextTheme,
}) => [
  Container(color: Colors.yellow, height: 10, width: 50),//provisional
  Flexible(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Text(
        'U2 L\' D R2 B\' L2 B2 D2 R2 U\' B2 U\' R2 U\' B2 R2 B\' U',
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textWidthBasis: TextWidthBasis.longestLine,
        style: TextStyle(
          fontSize: 18,
          height: 1,
          color: colorTextTheme,
        ),
      ),
    ),
  ),
  Container(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ///None hint funcionality added yet, TODO: future hint for crosses on 3x3 cube
        // IconButton(
        //   icon: Icon(
        //     CupertinoIcons.lightbulb,
        //     // Icons.wb_incandescent_outlined,
        //     color: colorTextTheme,
        //     size: 25,
        //   ),
        //   onPressed: () {
        //     // Add your onPressed code here!
        //   },
        // ),
        Row(
          children: [
            SizedBox(
              width: 30,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                CupertinoIcons.pencil,
                color: colorTextTheme,
                size: 20,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: 40,
              child: IconButton(
                icon: Icon(
                  // Icons.autorenew,
                  CupertinoIcons.arrow_2_circlepath,
                  color: colorTextTheme,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ),
          ],
        )
      ],
    ),
  )
];









//////////////////////////////
///CRONOMETER RESULTS ////////
//////////////////////////////
///Widget that shows the results of the cronometer like average of 5, 12, 50 and 100 and best, mean and count
class CronometerResults extends StatefulWidget {
  final bool breakNewRecord;
  final bool isRunning;
  final Color textColor;
  final Animation<double> buttonScaleAnimation;
  const CronometerResults({
    required this.isRunning,
    required this.textColor,
    required this.breakNewRecord,
    required this.buttonScaleAnimation,
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
        height: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, 
          children: [
          SizedBox(
            height: 5,
          ),
          Row(
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
                    style: TextStyle(color: widget.textColor, fontSize: 11),
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
                    style: TextStyle(color: widget.textColor, fontSize: 11),
                  ),
                ]),
              ]),
        ]));
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
    required this.breakNewRecord,
    required this.buttonScaleAnimation,
    required this.scaleAnimation,
    required this.containerHeight
  }) : _timer = timer;

  final Timer _timer;
  final double height;
  final double fontSize;
  final double containerHeight;
  final bool isTimerRunning;
  final bool breakNewRecord;
  final Color textColor;
  final Animation<double> buttonScaleAnimation;
  final Animation<double> scaleAnimation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: containerHeight > 400
                    ? height * 0.25
                    : 10
                ),
              child: Text(
                !isTimerRunning && breakNewRecord
                    ? "Congratulations! You've just beaten your previous personal  best by 12.23"
                    : containerHeight > 400 ? "\n" : "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: textColor,
                ),
              ),
            ),
            // SizedBox(
            //   height: height*0.2,
            // ),
            /////////////////////////////////
            ///Cronometer timing animation///
            /////////////////////////////////
            ScaleTransition(
              scale: scaleAnimation,
              child: Row(
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
            ),
            /////////////////////////////////////////
            //buttons in case of breaking best time//
            /////////////////////////////////////////
            Visibility(
              // visible: !isTimerRunning && breakNewRecord,
              visible: true,
              child: Container(
                height: containerHeight > 400 
                  ? 40
                  : 35,
                margin: EdgeInsets.only(top: containerHeight>400 ? 3 : 0),
                child: ScaleTransition(
                  scale: buttonScaleAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          CupertinoIcons.xmark,
                          // Icons.edit_outlined,
                          color: textColor,
                          size: 20,
                        ),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onPressed: () {},
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(
                        CupertinoIcons.slash_circle,
                        color: textColor,
                        size: 20,
                        ),
                        onPressed: () {},
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(
                          // Icons.autorenew,
                          CupertinoIcons.flag,
                          color: textColor,
                          size: 20,
                        ),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onPressed: () {},
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(
                          // Icons.autorenew,
                          CupertinoIcons.text_bubble,
                          color: textColor,
                          size: 20,
                        ),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onPressed: () {},
                      ),                      
                    ],
                  ),
                ),
              ),
            ),
          ]
        ),
    );
  }
}
