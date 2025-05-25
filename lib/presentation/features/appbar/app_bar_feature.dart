import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarHome extends StatefulWidget implements PreferredSizeWidget {
  final double widthDevice;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Color themeColor;
  final Color textColor;
  final int? actualPageIndex;
  final void Function()? onPressedDrawer;
  final void Function()? onPressedTittle;
  final void Function()? onPressedCategory;
  final bool isTimerRunnin;

  final String tittle;
  final String subtittle;
  // final Type typeCube;

  const AppBarHome({
    super.key,
    required this.onPressedDrawer,
    required this.onPressedTittle,
    required this.onPressedCategory,
    required this.themeColor,
    required this.textColor,
    required this.scaffoldKey,
    required this.isTimerRunnin,
    required this.tittle,
    required this.subtittle,
    this.widthDevice = 0,
    this.actualPageIndex,
    //required this.typeCube
  });

  @override
  State<AppBarHome> createState() => _AppBarHomeState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10.0);
}

class _AppBarHomeState extends State<AppBarHome>
    with SingleTickerProviderStateMixin {
  bool isRotated = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isTimerRunnin) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    return SafeArea(
      top: true,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(30),
                  spreadRadius: 0.3,
                  blurRadius: 2.5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            height: 180,
            alignment: AlignmentDirectional.center,
            margin: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: AppBar(
              key: widget.key,
              backgroundColor: widget.themeColor,
              titleSpacing: 0,
              centerTitle: true,
              title: SizedBox(
                width: 190,
                child: ElevatedButton(
                  style: ButtonStyle(
                    surfaceTintColor:
                        WidgetStateProperty.all<Color>(Colors.transparent),
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.transparent),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    shadowColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                  onPressed: widget.onPressedTittle,
                  child: _tittleCategory(widget.textColor),
                ),
              ),
              actions: [
                widget.actualPageIndex != 0
                    ? SizedBox(
                        width: 40.0,
                        child: IconButton(
                          iconSize: 22.0,
                          icon: AnimatedRotation(
                            turns: isRotated ? 5 / 6 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Platform.isIOS
                                ? Icon(
                                    color: CupertinoColors.white,
                                    isRotated
                                        ? CupertinoIcons
                                            .hourglass_bottomhalf_fill
                                        : CupertinoIcons.hourglass,
                                  )
                                : Icon(
                                    color: widget.textColor,
                                    isRotated
                                        ? Icons.hourglass_full_outlined
                                        : Icons.hourglass_empty_outlined,
                                  ),
                          ),
                          onPressed: () {
                            setState(() {
                              isRotated = !isRotated;
                            });
                          },
                        ))
                    : const SizedBox(width: 40),
                Container(
                    alignment: Alignment.center,
                    width: 35.0,
                    child: IconButton(
                        iconSize: 25.0,
                        icon: Icon(Icons.category_outlined,
                            color: widget.textColor),
                        onPressed: widget
                            .onPressedCategory //() async =>showAlertDialogNewCategory(context),),
                        )),
                const SizedBox(width: 15)
              ],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(17.0))),
              leadingWidth: 55.0,
              leading: Builder(builder: (context) {
                return Container(
                  width: 30,
                  margin: const EdgeInsets.only(left: 8),
                  child: IconButton(
                    icon: Icon(
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? CupertinoIcons.settings_solid
                          : Icons.settings_outlined,
                      color: widget.textColor,
                      size: 25.0,
                    ),
                    onPressed: widget.onPressedDrawer,
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  _tittleCategory(Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(widget.tittle,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    color: textColor)),
            Center(
              child: Text(
                widget.subtittle.length > 12
                    ? '${widget.subtittle.substring(0, 12)}...'
                    : widget.subtittle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.0,
                  color: textColor,
                ),
              ),
            )
          ],
        ),
        const SizedBox(width: 5),
        Icon(
          Icons.arrow_drop_down,
          color: textColor,
        )
      ],
    );
  }
}
