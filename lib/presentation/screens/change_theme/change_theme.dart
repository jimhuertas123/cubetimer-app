// import 'package:cube_timer_v2/config/config.dart';
import 'package:cube_timer_2/config/config.dart';
import 'package:cube_timer_2/presentation/widgets/drawer_widgets/custom_drawer.dart';
import 'package:cube_timer_2/presentation/widgets/theme_widget/theme_change.dart';
import 'package:flutter/material.dart';

import 'package:cube_timer_2/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {
  const ThemeChangerScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    // final double heightScreen = MediaQuery.of(context).size.height * (15 / 100);
    final ColorPair colorTheme = ref.watch(themeNotifierProvider).actualThemeColor;
    final Color actualAppbarBGColor = ref.watch(themeNotifierProvider).actualAppbarColor;
    final bool isDarkmode = ref.watch(themeNotifierProvider).isDarkmode;
    return SafeArea(
        bottom: true,
        top: false,
        child: Scaffold(
          key: scaffoldKey,
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: AppBarHome(
              textColor: (isDarkmode) ? Colors.black : Colors.white,  
              themeColor: actualAppbarBGColor,
              scaffoldKey: scaffoldKey,
              // onPressedDrawer: (){},
              onPressedDrawer: () => scaffoldKey.currentState!.openDrawer(),
              onPressedTittle: () => showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    tittle: 'App theme',
                    fontTittleSize: 20.0,
                    context: context,
                    insetPadding: const EdgeInsets.symmetric(horizontal: 30),
                    contentPadding:
                      const EdgeInsets.only(right: 0, left: 0, top: 15),
                    content: const <Widget>[
                      ThemeChange(),
                    //   _changeTheme(colorTheme, ref),
                    //   _changeTheme(colorTheme, ref),
                      // SizedBox(
                      //   height: 300,
                      //   child: GridView.count(
                      //     padding: const EdgeInsets.all(0.0),
                      //     crossAxisSpacing: 4.0,
                      //     mainAxisSpacing: 0.0,
                      //     physics: const BouncingScrollPhysics(),
                      //     crossAxisCount: 3,
                      //     children:
                      //         List.generate(icon_list.length, (index) {
                      //       return Container(
                      //         width: 10,
                      //         height: 10,
                      //         padding: const EdgeInsets.all(0),
                      //         color: Colors.green,
                      //         child: ElevatedButton(
                      //             onPressed: () {},
                      //             style: ButtonStyle(
                      //               fixedSize: MaterialStateProperty.all(Size(2, 2)),
                      //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      //                   RoundedRectangleBorder(
                      //                       borderRadius: BorderRadius.circular(20),
                      //                       // side: BorderSide(color: Colors.yellow)
                      //                   )),
                      //               padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                      //             ),
                      //             child: _customButton(
                      //                 category:
                      //                     'Cubo ${index + 2}x${index + 2}',
                      //                 icon: icon_list[index])),
                      //       );
                      //     }),
                      //   )),
                      ],
                    )
              ),
            ),
            body: Container(
              padding: EdgeInsets.zero,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorTheme.primaryColor,
                    colorTheme.secondaryColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            bottomNavigationBar: const CustomBottomNavigationBar(),
            drawer: const DrawerHome()
            
      ),
      

    
    );
  }

  _customButton({required Image icon, required String category}) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Alinea el contenido al centro
      children: [
        icon, // Icono
        const SizedBox(height: 8.0), // Espacio entre el icono y el texto
        Text(
          category,
          style: const TextStyle(color: Colors.black),
        ), // Texto
      ],
    );
  }
  
}
