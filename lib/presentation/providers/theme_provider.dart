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
          statusBarTextColor: Brightness.light,
          actualThemeIndex: 0,
          actualTextThemeIndex: 0,
          isDarkmode: appColorTheme[0].isDarkmode,
        ));

  void toggleDarkmode() {
    state =
        state.copyWith(statusBarTextColor: Brightness.light, isDarkmode: true);
  }

  void toggleLightMode() {
    state =
        state.copyWith(statusBarTextColor: Brightness.dark, isDarkmode: false);
  }

  void changeTextColorIndex(int indexTextColor) {
    if (appTextTheme.length >= indexTextColor) {
      state = state.copyWith(
        actualTextThemeIndex: indexTextColor);
    }
  }

  bool isDarkMode() {
    return state.isDarkmode;
  }

  void changeThemeColorIndex(int indexThemeColor) {
    print(state.actualTextThemeIndex);
    state = state.copyWith(
      actualThemeIndex: indexThemeColor
    );

    if (appColorTheme[indexThemeColor].isDarkmode == true) {
      toggleDarkmode();
    } else if (appColorTheme[indexThemeColor].isDarkmode == false) {
      toggleLightMode();
    }
  }
}
