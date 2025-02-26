// import 'package:cube_timer_v2/config/config.dart';
import 'package:cube_timer_2/config/config.dart';
import 'package:cube_timer_2/presentation/features/features.dart';
import 'package:cube_timer_2/presentation/providers/providers.dart';
import 'package:cube_timer_2/presentation/widgets/puzzle_widgets/puzzle_selection.dart';

import 'package:flutter/material.dart';

import 'package:cube_timer_2/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  // final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    //body changes
    final int selectedOption = ref.watch(menuOptionsNotifierProvider).actualOption;

    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
          key: scaffoldKey,
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBarHome(
            actualPageIndex: indexPage,
            textColor: (actualTextColorIndex == 0)
                ? (isDarkMode)
                    ? Colors.black
                    : Colors.white
                : appTextTheme[actualTextColorIndex].colorText,
            themeColor: appColorTheme[actualThemeIndex].appBarColor,
            scaffoldKey: scaffoldKey,
            onPressedDrawer: () => scaffoldKey.currentState?.openDrawer(),
            
            //tittle change according to the selected option
            // tittle: appMenuScreensItems[selectedOption].title,
            // subtittle: 'xd',
            onPressedTittle: () => 
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  tittle: 'Select a puzzle',
                  fontTittleSize: 20.0,
                  context: context,
                  insetPadding: const EdgeInsets.symmetric(horizontal: 30),
                  contentPadding: const EdgeInsets.only(
                      right: 0, left: 0, top: 0, bottom: 0),
                  content: const <Widget>[
                    PuzzleSelection(),
                  ],
                )),
          ),
          body: _getBodyContent(pageController, appColorTheme[actualThemeIndex].patternColor ,selectedOption, actualThemeIndex, ref, context),
          bottomNavigationBar: selectedOption == 0 || selectedOption == 2 || selectedOption == 3
            ? CustomBottomNavigationBar(
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
              )
            : null,
          drawer: const DrawerHome()),
    );
  }

  Widget _getBodyContent( PageController pageController, ColorPair patternColor,
      int currentOption, int actualThemeIndex, WidgetRef ref, context)  {
    switch (currentOption) {
      case 0:
        return MainBody(
          optionBody: 0, //main body in constructor
          patternColor: appColorTheme[actualThemeIndex].patternColor,
          pageController: pageController
        );
      case 2:
        return MainBody(
          optionBody: 1, //oll training body in constructor
          patternColor: const ColorPair(primaryColor: Colors.black, secondaryColor: Colors.white),
          pageController: pageController
        );
      case 3:
        return MainBody(
          optionBody: 2, //pll training body in constructor
          patternColor: const ColorPair(primaryColor: Colors.red, secondaryColor: Colors.green),
          pageController: pageController
        );
      case 5:
        return const Center(child: Text("Contenido de Opción 2"));
      case 6:
        return const Center(child: Text("Contenido de Opción 2"));
      default:
        return const Center(child: Text("Selecciona una opción en el Drawer"));
    }
  }
}
