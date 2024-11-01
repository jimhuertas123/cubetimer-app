import 'package:cube_timer_2/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final isDarkmodeProvider = StateProvider((ref) => false);
final selectedColorProvider = StateProvider((ref) => 0);
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier()
      : super(AppTheme(
            actualAppbarColor: appColorTheme[0].appBarColor,
            actualBnbarColor: appColorTheme[0].bnBarColor,
            actualThemeColor: appColorTheme[0].patternColor,
            actualTextColor: appTextTheme[0].colorText));

  void toggleDarkmode() {
    state = state.copyWith(
        statusBarTextColor: Brightness.light,
        isDarkmode: true,
        actualTextColor:
            (state.indexTextColor == 0) ? whiteColor : state.actualTextColor);
  }

  void toggleLightMode() {
    state = state.copyWith(
        statusBarTextColor: Brightness.dark,
        isDarkmode: false,
        actualTextColor:
            (state.indexTextColor == 0) ? blackColor : state.actualTextColor);
  }

  void changeTextColorIndex(int indexTextColor) {
    if (appTextTheme.length >= indexTextColor) {
      state = state.copyWith(
          actualTextColor: appTextTheme[indexTextColor].colorText,
          indexTextColor: indexTextColor);
    }
  }

  bool isDarkMode() {
    return state.isDarkmode;
  }

  void changeThemeColorIndex(int indexThemeColor) {
    print(state.indexTextColor);
    state = state.copyWith(
      indexThemeColor: indexThemeColor,
      actualThemeColor: appColorTheme[indexThemeColor].patternColor,
      indexAppbarColor: indexThemeColor,
      actualAppbarColor: appColorTheme[indexThemeColor].appBarColor,
      indexBnbarColor: indexThemeColor,
      actualBnbarColor: appColorTheme[indexThemeColor].bnBarColor,
    );

    if (appColorTheme[indexThemeColor].isDarkmode == true) {
      toggleDarkmode();
    } else if (appColorTheme[indexThemeColor].isDarkmode == false) {
      toggleLightMode();
    }
  }
}
