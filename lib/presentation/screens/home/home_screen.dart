// import 'package:cube_timer_v2/config/config.dart';
import 'package:cube_timer_2/config/config.dart';
import 'package:cube_timer_2/presentation/features/body_contents/body_main.dart';
import 'package:cube_timer_2/presentation/features/custom_drawer_feature.dart';
import 'package:cube_timer_2/presentation/providers/menu_controller.dart';
import 'package:cube_timer_2/presentation/widgets/theme_widget/theme_change.dart';
import 'package:flutter/material.dart';

import 'package:cube_timer_2/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/theme_provider.dart';

class HomeScreen extends ConsumerWidget {
  
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final bool isDarkMode = ref.watch(themeNotifierProvider).isDarkmode;
    final int actualThemeIndex =
        ref.watch(themeNotifierProvider).actualThemeIndex;
    final int actualTextColorIndex =
        ref.watch(themeNotifierProvider).actualTextThemeIndex;

    //automatic scroll purpose
    final indexPage = ref.watch(pageIndexProviderInt);
    final PageController pageController = PageController(
      keepPage: true,
      initialPage: indexPage,
    );

    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
          key: scaffoldKey,
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBarHome(
            textColor: (actualTextColorIndex == 0)
                ? (isDarkMode)
                    ? Colors.black
                    : Colors.white
                : appTextTheme[actualTextColorIndex].colorText,
            themeColor: appColorTheme[actualThemeIndex].appBarColor,
            scaffoldKey: scaffoldKey,
            onPressedDrawer: () => scaffoldKey.currentState!.openDrawer(),
            onPressedTittle: () => showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                      tittle: 'App theme',
                      fontTittleSize: 20.0,
                      context: context,
                      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
                      contentPadding: const EdgeInsets.only(
                          right: 0, left: 0, top: 15, bottom: 0),
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
                    )),
          ),
          body: BodyContent(
            patternColor: appColorTheme[actualThemeIndex].patternColor, 
            pageController: pageController
          ),
          // body: PageView.builder(
          //   controller: pageController,
          //   itemCount: 3,
          //   onPageChanged: (index) {
          //     ref.read(pageIndexProviderInt.notifier).setPageIndex(index);
          //   },
          //   itemBuilder: (context, index) {
          //     return Container(
          //       color: index == 0
          //           ? Colors.red
          //           : index == 1
          //               ? Colors.green
          //               : Colors.blue,
          //       child: Center(
          //         child: Text(
          //           'Page $index',
          //           style: TextStyle(color: Colors.white, fontSize: 24),
          //         ),
          //       ),
          //     );
          //   },
          // ),
          bottomNavigationBar: CustomBottomNavigationBar(
            pageController: pageController,
            backgroundColor: appColorTheme[actualThemeIndex].bnBarColor,
            activeIconColor: actualTextColorIndex == 0
                ? appColorTheme[actualThemeIndex].isDarkmode
                    ? Colors.black
                    : Colors.white
                : appTextTheme[actualTextColorIndex].colorText,
            inactiveIconColor: appColorTheme[actualThemeIndex].isDarkmode
                ? Colors.black54
                : Colors.white54,
            onTap: (index) {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              ref.read(pageIndexProviderInt.notifier).setPageIndex(index);
            },
          ),
          drawer: const DrawerHome()),
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
