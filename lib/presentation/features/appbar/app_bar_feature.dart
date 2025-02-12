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

  final String tittle;
  final String subtittle;
  // final Type typeCube;

  const AppBarHome({
    required this.onPressedDrawer,
    required this.onPressedTittle,
    required this.themeColor,
    required this.textColor,
    required this.scaffoldKey,
    super.key,
    this.widthDevice = 0,
    this.tittle = 'Cubo 3x3',
    this.subtittle = 'normal', 
    this.actualPageIndex,
    //required this.typeCube
  });

  @override
  State<AppBarHome> createState() => _AppBarHomeState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10.0);
}

class _AppBarHomeState extends State<AppBarHome> {

  bool isRotated = false;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
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
            width: 170,
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
                    child: Icon(
                      color: widget.textColor,
                      isRotated ? Icons.hourglass_full_outlined : Icons.hourglass_empty_outlined,
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
                  icon: Icon(Icons.category_outlined, color: widget.textColor),
                  onPressed: (() => debugPrint(
                      "momento god")), //() async =>showAlertDialogNewCategory(context),),
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
            Text(widget.subtittle, style: TextStyle(fontSize: 12.0, color: textColor))
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
