import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cube_timer_2/config/theme/app_theme.dart';
import '../../providers/theme_provider.dart';
import '../widgets.dart';

class ThemeChange extends ConsumerWidget {
  const ThemeChange({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int halfSize = (appColorTheme.length / 2).round();
    final ColorPair colorTheme =
        ref.watch(themeNotifierProvider).actualThemeColor;

    return Column(children: <Widget>[
      themeSection(halfSize, ref),
      Container(
        padding: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        color: const Color.fromRGBO(242,242,242,1),
        width: 400,
        height: 45,
        child: const Text(
          "Text style",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      textStyleSection(colorTheme, ref)
    ]);
  }

  Widget themeSection(int halfSize, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 7),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            _themeType(0, halfSize, ref),
            const SizedBox(height: 10), 
            _themeType(halfSize, appColorTheme.length, ref),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _themeType(int start, int end, WidgetRef ref) {
    final AppTheme actualAppColorTheme =
        ref.watch(themeNotifierProvider);
    return Row(
      children: <Widget>[
        ...appColorTheme
            .sublist(start, end)
            .asMap()
            .map((index, colorArrText) {
              final int actualIndex = index + start;
              return MapEntry(
                actualIndex,
                ThemeContainer(
                  isSelected: (actualAppColorTheme.indexThemeColor == actualIndex) ? true : false,
                  colors: appColorTheme[actualIndex].patternColor,
                  tittle: appColorTheme[actualIndex].name,
                  backgroundTextColor: Colors.transparent,
                  onTap: () {
                    ref
                        .read(themeNotifierProvider.notifier)
                        .changeThemeColorIndex(actualIndex);
                  },
                ),
              );
            })
            .values
            .toList(),
      ],
    );
  }

  Widget textStyleSection(ColorPair colorTheme, WidgetRef ref) {
    final int halfSize = (appTextTheme.length / 2).round();
    return Container(
        padding: EdgeInsets.zero,
        width: double.infinity,
        height: 150,
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
        // child: _textType2(ref));
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(children: <Widget>[
        _textType(0, halfSize, ref),
      ])
    ));
  }

  Widget _textType(int start, int end, WidgetRef ref) {
    final int actualIndexTextColor =
        ref.watch(themeNotifierProvider).indexTextColor;
    final Color actualColorText = ref.watch(themeNotifierProvider).actualTextColor;
    final bool isDarkMode =
        ref.watch(themeNotifierProvider).isDarkmode;
    final int selectedTextIndex =
        ref.watch(themeNotifierProvider).indexTextColor;
    
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        ...appTextTheme
            .sublist(start, end)
            .asMap()
            .map((index, e) {
              final int actualIndex = index + start;
              return MapEntry(
                  actualIndex,
                  TextThemeContainer(
                    name: e.name,
                    textColor: selectedTextIndex == 0 
                      ? isDarkMode 
                        ? Colors.black
                        : Colors.white
                      : actualColorText,
                    color:  actualIndex == 0 
                      ? isDarkMode 
                        ? Colors.black
                        : Colors.white
                      : e.colorText,
                    borderColor: selectedTextIndex == 0 
                      ? isDarkMode 
                        ? Colors.black
                        : Colors.white
                      : actualColorText,
                    isSelected:
                        (actualIndexTextColor == actualIndex) ? true : false,
                    onTap: () {
                      ref
                          .read(themeNotifierProvider.notifier)
                          .changeTextColorIndex(actualIndex);
                    },
                  ));
            })
            .values
            .toList(),
      ],
    );
  }

  Widget deprecated__textType(ref) {
    final int actualTextColorTheme =
        ref.watch(themeNotifierProvider).indexTextColor;
    final bool isDarkmode = ref.watch(themeNotifierProvider).isDarkmode;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: appTextTheme.length,
      itemBuilder: (_, index) {
        return TextThemeContainer(
          name: appTextTheme[index].name,
          textColor: (isDarkmode) ? Colors.black : Colors.white,
          color: (index == 0)
              ? (isDarkmode)
                  ? Colors.black
                  : Colors.white
              : appTextTheme[index].colorText,
          borderColor: (isDarkmode) ? Colors.black : Colors.white,
          isSelected: (actualTextColorTheme == index) ? true : false,
          onTap: () {
            ref
              .read(themeNotifierProvider.notifier)
              .changeTextColorIndex(index);
          },
        );
      },
    );
  }
}
