import 'package:cube_timer_2/config/config.dart';
import 'package:cube_timer_2/config/database/config_database.dart';
import 'package:cube_timer_2/presentation/features/features.dart';
import 'package:cube_timer_2/presentation/providers/providers.dart';
import 'package:cube_timer_2/presentation/widgets/puzzle_widgets/puzzle_selection.dart';

import 'package:flutter/material.dart';

import 'package:cube_timer_2/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../database/models/models.dart';

final GlobalKey<ScaffoldState> scaffoldKeyAndroid = GlobalKey<ScaffoldState>();

///It is the main screen of the app
///in contains the appBar, body and bottom navigation bar
class AndroidHomeScreen extends ConsumerWidget {
  const AndroidHomeScreen({super.key});
  // final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //gemeral config theme
    final bool isDarkMode = ref.watch(themeNotifierProvider).isDarkmode;
    final int actualThemeIndex =
        ref.watch(themeNotifierProvider).actualThemeIndex;
    final int actualTextColorIndex =
        ref.watch(themeNotifierProvider).actualTextThemeIndex;

    //automatic scroll purpose -when scrolling pageview-
    final indexPage = ref.watch(pageIndexProviderInt);
    final PageController pageController = PageController(
      keepPage: true,
      initialPage: indexPage,
    );

    //body changes
    final int selectedOption =
        ref.watch(menuOptionsNotifierProvider).actualOption;
    final bool isTimerRunning = ref.watch(cronometerRunnerProvider).isRunning;

    //appBar category changes
    //appBar category changes
    final CubeTypeModel actualOption =
        ref.watch(cubeTypeProvider).actualCubeType;
    final List<CubeTypeModel> appMenuScreensItems =
        ref.watch(cubeTypeProvider).cubeTypes;

    final CategoryModel actualCategory =
        ref.watch(categoryProvider).actualCategory;

    final categoryState = ref.watch(categoryFutureProvider);

    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
          key: scaffoldKeyAndroid,
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBarHome(
            isTimerRunnin: isTimerRunning,
            actualPageIndex: indexPage,
            tittle: "${actualOption.type.name} Cube",
            subtittle: categoryState.when(
              loading: () => 'Loading...',
              data: (categories) => actualCategory.name.isEmpty
                  ? categories[0].name.toLowerCase()
                  : actualCategory.name.toLowerCase(),
              error: (err, stack) => 'Error loading categories',
            ),
            textColor: (actualTextColorIndex == 0)
                ? (isDarkMode)
                    ? Colors.black
                    : Colors.white
                : appTextTheme[actualTextColorIndex].colorText,
            themeColor: appColorTheme[actualThemeIndex].appBarColor,
            scaffoldKey: scaffoldKeyAndroid,
            onPressedDrawer: () =>
                scaffoldKeyAndroid.currentState?.openDrawer(),

            //tittle change according to the selected option
            // tittle: appMenuScreensItems[selectedOption].title,
            // subtittle: 'xd',
            onPressedTittle: () => showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                      enableHeight: true,
                      height: 370,
                      tittleContent: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 0),
                        child: Center(
                          child: Text("Select a puzzle",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              )),
                        ),
                      ),
                      fontTittleSize: 20.0,
                      context: context,
                      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
                      contentPadding: const EdgeInsets.only(
                          right: 0, left: 0, top: 0, bottom: 0),
                      content: <Widget>[
                        PuzzleSelection(
                          cubeTypes: appMenuScreensItems,
                        ),
                      ],
                    )),
            onPressedCategory: () => showDialog(
                context: context,
                builder: (context) {
                  // final List<CategoryModel> actualCategories =
                  //     ref.watch(categoryProvider.notifier).loadCategoriesForCurrentCubeType(actualOption);

                  return CustomAlertDialog(
                    enableHeight: false,
                    insetPadding: EdgeInsets.symmetric(horizontal: 50),
                    context: context,
                    tittleContent: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Select a category",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () => showDialog(
                                barrierColor:
                                    Colors.black.withValues(alpha: 0.5),
                                context: context,
                                builder: (context) =>
                                    AndroidNewCategoryAlertDialog()),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF2962ff),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/icons/ic_add_category.svg',
                                    width: 22,
                                    height: 22,
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    "New",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF2962ff),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    content: <Widget>[
                      Divider(),
                      Consumer(builder: (context, ref, child) {
                        final categoryState = ref.watch(categoryFutureProvider);
                        return categoryState.when(
                          loading: () =>
                              const CircularProgressIndicator.adaptive(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          error: (err, stack) => Center(
                            child: Text(
                              'Error loading categories',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          data: (categories) {
                             categories.sort((a, b) => a.name.compareTo(b.name));
                            return CategorySelection(
                              categories: categories,
                            );
                          },
                        );
                      }),
                      Divider(),
                      Center(
                          child: Text(
                        'Long-press an entry to edit',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      )),
                      SizedBox(height: 5),
                    ],
                  );
                }),
          ),
          body: _getBodyContent(
              pageController,
              appColorTheme[actualThemeIndex].patternColor,
              selectedOption,
              actualThemeIndex,
              actualTextColorIndex,
              ref,
              context),
          bottomNavigationBar: selectedOption == 0 ||
                  selectedOption == 2 ||
                  selectedOption == 3
              ? CustomBottomNavigationBar(
                  isTimerRunning: isTimerRunning,
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

  Widget _getBodyContent(PageController pageController, ColorPair patternColor,
      int currentOption, int actualThemeIndex,int actualTextColorIndex, WidgetRef ref, context) {
    switch (currentOption) {
      case 0:
        return MainBody(
            optionBody: 0, //main body in constructor
            actualTextColorIndex: actualTextColorIndex,
            patternColor: appColorTheme[actualThemeIndex].patternColor,
            pageController: pageController);
      case 2:
        return MainBody(
            optionBody: 1, //oll training body in constructor
            actualTextColorIndex: actualTextColorIndex,
            patternColor: const ColorPair(
                primaryColor: Colors.black, secondaryColor: Colors.white),
            pageController: pageController);
      case 3:
        return MainBody(
            optionBody: 2, //pll training body in constructor
            actualTextColorIndex: actualTextColorIndex,
            patternColor: const ColorPair(
                primaryColor: Colors.red, secondaryColor: Colors.green),
            pageController: pageController);
      case 5:
        return const Center(child: Text("Contenido de Opción 2"));
      case 6:
        return const Center(child: Text("Contenido de Opción 2"));
      default:
        return const Center(child: Text("Selecciona una opción en el Drawer"));
    }
  }
}
