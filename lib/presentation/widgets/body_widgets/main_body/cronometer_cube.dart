import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

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
  Offset? _targetPosition;
  Size? _targetSize;

  void _updateTargetPosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? box =
          _targetKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null && mounted) {
        setState(() {
          _targetPosition = box.localToGlobal(Offset.zero);
          _targetSize = box.size;
        });
        debugPrint('Posición: $_targetPosition, Tamaño: $_targetSize');
      }
    });
  }

  // void _updateTargetPosition2() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final RenderBox? box =
  //         _targetKey.currentContext?.findRenderObject() as RenderBox?;
  //     if (box != null && mounted) {
  //       setState(() {
  //         _targetPosition = box.localToGlobal(Offset.zero);
  //         _targetSize = box.size;
  //       });
  //       debugPrint('Posición: $_targetPosition, Tamaño: $_targetSize');
  //     }
  //   });
  // }

  void _updateBrokedRecord() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cronometerRunnerProvider.notifier).breakedNewRecord(false);
    });
  }

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

    _updateTargetPosition();
    _updateBrokedRecord();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final orientation = MediaQuery.of(context).orientation;
    if (_lastOrientation != orientation) {
      _lastOrientation = orientation;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateTargetPosition();
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    _animationTimeBrokedController.dispose();
    super.dispose();
  }

  //for showing new average message
  final GlobalKey _targetKey = GlobalKey();
  Orientation? _lastOrientation;

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
      child: Stack(
        children: [
          // text message for new average (only vertical orientation)
          if (_targetPosition != null && widget.containerHeight <= 400)
            Positioned(
              left: 0,
              top: _targetPosition?.dy != null ?  _targetPosition!.dy - 120 : widget.containerHeight * 0.5,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  // vertical: 1,
                  horizontal: 14,
                ),
                child: Text(
                  !isRunning && brokedNewRecord
                      ? "Congratulations! \nYou've just beaten your \nprevious personal best by \n12.23"
                      : "",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorTextTheme,
                      fontSize: 14,
                      height: 1.2),
                ),
              ),
            ),

          //cronometer main body
          SafeArea(
            child: GestureDetector(
              onTap: () => {
                if (isRunning == false)
                  {
                    ref
                        .read(cronometerRunnerProvider.notifier)
                        .isTimerRunning(!isRunning),
                    ref
                        .read(cronometerRunnerProvider.notifier)
                        .breakedNewRecord(true),
                    debugPrint("isRunning: $isRunning"),
                    startTimer(isRunning)
                  }
              },
              child: Container(
                margin:
                    EdgeInsets.only(top: widget.containerWidth > 400 ? 5 : 10),
                color: Colors.transparent,
                child: Stack(children: [
                  //green circle
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                        // Expanded(
                        //   child: Container(
                        //     width: double.infinity,
                        //     color: Colors.red,
                        //     child: FittedBox(
                        //       fit: BoxFit.fill,
                        //       child: Container(
                        //         width: 300,
                        //         height: 300,
                        //         alignment: Alignment.center,
                        //         color: Colors.orange,
                        //       ),
                        //     ),
                        //   ),
                        // ),
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

                        // SizedBox(
                        //   height: widget.containerHeight > 400
                        //       ? 170
                        //       : _targetSize != null
                        //           ? _targetSize!.height - 30
                        //           : 70,
                        // ),

                        //RESULTS
                        // SlideTransition(
                        //   position: _slideAnimationResults,
                        //   child: FadeTransition(
                        //     opacity: _fadeAnimation,
                        //     child: CronometerResults(
                        //         buttonScaleAnimation: _buttonScaleAnimation,
                        //         isRunning: isRunning,
                        //         breakNewRecord: brokedNewRecord,
                        //         textColor: colorTextTheme),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
          SafeArea(
            bottom: true,
            child: GestureDetector(
                onTap: () {
                  if (isRunning == false) {
                    ref
                        .read(cronometerRunnerProvider.notifier)
                        .isTimerRunning(!isRunning);
                    startTimer(isRunning);
                  }
                },
                child: SlideTransition(
                  position: _slideAnimationResults,
                  child: Align(
                    alignment: Alignment.bottomCenter, // O donde prefieras
                    child: CronometerResults(
                      key: _targetKey,
                      buttonScaleAnimation: _buttonScaleAnimation,
                      isRunning: isRunning,
                      breakNewRecord: brokedNewRecord,
                      containerHeight: widget.containerHeight,
                      textColor: colorTextTheme,
                    ),
                  ),
                )),
          ),
          if (_targetPosition != null)
            Positioned(
              right: 5,
              top:  _targetPosition?.dy != null ? _targetPosition!.dy - 15 : 80, // Por ejemplo, justo arriba
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 1,
                  horizontal: 7,
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
                  !isRunning && brokedNewRecord ? "¡New Average Best!" : "",
                  style: TextStyle(
                      color: colorTextTheme,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          if (isRunning)
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (isRunning == true) {
                    ref
                        .read(cronometerRunnerProvider.notifier)
                        .isTimerRunning(!isRunning);
                    startTimer(isRunning);
                  }
                },
              ),
            )
        ],
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
    required this.containerHeight,
  });

  final double containerHeight;
  final double scrambleHeight;
  final CronometerCube widget;
  final Color colorTextTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.orange,
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
}) =>
    [
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
                  onPressed: () {
                    debugPrint("Scramble");
                  },
                ),
              ],
            )
          ],
        ),
      )
    ];

List<Widget> _scrambleInfoRow({
  required Color colorTextTheme,
}) =>
    [
      SizedBox(width: 20),
      Container(color: Colors.yellow, height: 10, width: 50), //provisional
      Flexible(
        fit: FlexFit.tight,
        child: Container(
          // color: Colors.red,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            'U2 L\' D R2 B\' L2 B2 D2 R2 U\' B2 U\' R2 U\' B2 R2 B\' U',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textWidthBasis: TextWidthBasis.longestLine,
            style: TextStyle(
              fontSize: 17,
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
      ),
      SizedBox(width: 20)
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
  final double containerHeight;
  const CronometerResults({
    required this.isRunning,
    required this.textColor,
    required this.breakNewRecord,
    required this.buttonScaleAnimation,
    required this.containerHeight,
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
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        width: double.infinity,
        height: 80,
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
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
                Expanded(
                  child: Container(
                    alignment: widget.containerHeight <= 400
                        ? Alignment.topLeft
                        : Alignment.topCenter,
                    child: Hero(
                      tag: 'cubeHero',
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false,
                              barrierColor: Colors.transparent,
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return const CubeFullScreen();
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/drawer_templates/3x3.svg',
                          fit: BoxFit.contain,
                          height: 70,
                        ),
                      ),
                    ),
                  ),
                ),
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

class CubeFullScreen extends StatelessWidget {
  const CubeFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Center(
          child: Hero(
            tag: 'cubeHero',
            child: SvgPicture.asset(
              'assets/drawer_templates/3x3.svg',
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
      ),
    );
  }
}

class CronometerTime extends StatelessWidget {
  const CronometerTime(
      {super.key,
      required this.textColor,
      required this.height,
      required Timer timer,
      required this.isTimerRunning,
      required this.fontSize,
      required this.breakNewRecord,
      required this.buttonScaleAnimation,
      required this.scaleAnimation,
      required this.containerHeight, 
    })
      : _timer = timer;

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
      child: Container(
        padding: EdgeInsets.only(
          bottom: 73),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              !isTimerRunning && breakNewRecord && containerHeight > 400
                  ? SizedBox(
                      height: 90,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Text(
                          !isTimerRunning &&
                                  breakNewRecord &&
                                  containerHeight > 400
                              ? "Congratulations! ${containerHeight > 400 ? '\n' : ''} You've just beaten your previous personal best by ${containerHeight > 400 ? '\n' : ''} 12.23"
                              : '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: textColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: containerHeight > 400 ? 90 : 0,
                    ),
              // SizedBox(
              //   height: height*0.2,
              // ),
              /////////////////////////////////
              ///Cronometer timing animation///
              /////////////////////////////////
              containerHeight > 400
                  ? _cronometer()
                  : Expanded(child: _cronometer()),

              /////////////////////////////////////////
              //buttons in case of breaking best time//
              /////////////////////////////////////////
              Container(
                height: containerHeight > 400 ? 40 : 35,
                margin: EdgeInsets.only(top: containerHeight > 400 ? 3 : 0),
                child: ScaleTransition(
                  scale: buttonScaleAnimation,
                  child: Visibility(
                    visible: !isTimerRunning && breakNewRecord,
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
                          onPressed: () {
                            debugPrint("Xmark");
                          },
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
            ]),
      ),
    );
  }

  ScaleTransition _cronometer() {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Container(
        // color: Colors.orange,
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
    );
  }
}
