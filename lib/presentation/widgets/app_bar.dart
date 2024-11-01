import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final double widthDevice;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Color themeColor;
  final Color textColor;
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
    //required this.typeCube
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0.3,
              blurRadius: 0.5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        height: 180,
        alignment: AlignmentDirectional.center,
        margin: const EdgeInsets.only(top:8.0 ,left: 8.0, right: 8.0),
        child: AppBar(
          backgroundColor: themeColor,
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
              onPressed: onPressedTittle,
              child: _tittleCategory(textColor),
            ),
          ),
          actions: [
            // (context.watch<ViewsModel>().selectedIndex != 0)
            // ? SizedBox(
            //   width: 40.0,
            //   child: IconButton(
            //     iconSize: 22.0,
            //     icon: const Icon(Icons.hourglass_empty_outlined),
            //     onPressed: (){},),
            // )
            // :
            // const SizedBox(width: 40),
            Container(
                alignment: Alignment.center,
                width: 35.0,
                child: IconButton(
                  iconSize: 25.0,
                  icon: Icon(Icons.category_outlined, color: textColor),
                  onPressed: (() => print("momento god")), //() async =>showAlertDialogNewCategory(context),),
                )),
            const SizedBox(width: 15)
          ],
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(17.0))),
          leadingWidth: 55.0,
          leading: Builder(
            builder: (context) {
              return Container(
                width: 30,
                margin: const EdgeInsets.only(left: 8),
                child: IconButton(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: textColor,
                    size: 25.0,
                  ),
                  onPressed: onPressedDrawer,
                  // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              );
            }
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
            Text(tittle,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: textColor)
            ),
            Text(subtittle, style: TextStyle(fontSize: 12.0, color: textColor))
          ],
        ),
        const SizedBox(width: 5),
        Icon(Icons.arrow_drop_down, color: textColor,)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10.0);
}
