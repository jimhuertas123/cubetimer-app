import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorPair {
  final Color primaryColor;
  final Color secondaryColor;

  const ColorPair({
    required this.primaryColor,
    required this.secondaryColor,
  });
}

class ColorAppTheme {
  final ColorPair patternColor;
  final bool isDarkmode;
  final Color appBarColor;
  final Color bnBarColor;
  final String name;

  const ColorAppTheme({
    required this.patternColor,
    required this.appBarColor,
    required this.bnBarColor,
    required this.isDarkmode,
    required this.name,
  });
}

class TextTheme {
  final Color colorText;
  final String name;

  const TextTheme({required this.colorText, required this.name});
}

const appColorTheme = <ColorAppTheme> [
  ColorAppTheme(//1
      isDarkmode: false,
      patternColor: ColorPair(
          primaryColor: Color(0xFF0062ff), secondaryColor: Color(0xFF3b12ff)),
      appBarColor:Color(0xff0045f6),
      bnBarColor: Color(0xff2900ef),
      name: 'Hazy\nBlues'),
  ColorAppTheme(//2
      isDarkmode: false,
      patternColor: ColorPair(
          primaryColor: Color(0xFF0D0D0D), secondaryColor: Color(0xFF0D0D0D)),
      appBarColor:Color(0xFF171717),
      bnBarColor: Color(0xFF171717),
      name: 'Spotty\nGuy'),
  ColorAppTheme(//3
      isDarkmode: true,
      patternColor: ColorPair(
          primaryColor: Color(0xFFFFFFFF), secondaryColor: Color(0xFFFFFFFF)),
      appBarColor:Color(0xFFFFFEFF),
      bnBarColor: Color(0xFFffffff),
      name: 'Simply\nWhite'),
  ColorAppTheme(//4
      isDarkmode: false,
      patternColor: ColorPair(
          primaryColor: Color(0xFF607D8B), secondaryColor: Color(0xFF455A64)),
      appBarColor:Color(0xFF678695),
      bnBarColor: Color(0xFF3e515a),
      name: 'Bluy\nGray'),
  ColorAppTheme(//5
      isDarkmode: true,
      patternColor: ColorPair(
          primaryColor: Color(0xFFfcd6e3), secondaryColor: Color(0xFFaaf0ed)),
      appBarColor:Color(0xFFfde6ee),
      bnBarColor: Color(0xFF8debe7),
      name: 'Pixie\nFalls'),
  ColorAppTheme(//6
      isDarkmode: false,
      patternColor: ColorPair(
          primaryColor: Color(0xFF8e78ff), secondaryColor: Color(0xFFfc7d7b)),
      appBarColor:Color(0xFF8067ff),
      bnBarColor: Color(0xFFfb5c5a),
      name: 'Wandy\nDusk'),
  ColorAppTheme(//7
      isDarkmode: false,
      patternColor: ColorPair(
          primaryColor: Color(0xFFED1E79), secondaryColor: Color(0xFF662D8C)),
      appBarColor:Color(0xFFd81169),
      bnBarColor: Color(0xFF5d297f),
      name: 'Quite\nPurply'),
  ColorAppTheme(//8
      isDarkmode: false,
      patternColor: ColorPair(
          primaryColor: Color(0xFF673AB7), secondaryColor: Color(0xff512DA8)),
      appBarColor:Color(0XFF6e40c2),
      bnBarColor: Color(0xFF4b299b),
      name: 'Definitely\nPurple'),
  ColorAppTheme(//9
      isDarkmode: false,
      patternColor: ColorPair(
          primaryColor: Color(0xffFF577E), secondaryColor: Color(0xFFFD61C0)),
      appBarColor:Color(0xffFF678A),
      bnBarColor: Color(0xfffd50b9),
      name: 'Pinky\nPromises'),
  ColorAppTheme(//10
      isDarkmode: true,
      patternColor: ColorPair(
          primaryColor: Color(0xFF18ff97), secondaryColor: Color(0xFF24f594)),
      appBarColor:Color(0xff29ff9f),
      bnBarColor: Color(0xff0bec84),
      name: 'Earthy\nTeal'),
  ColorAppTheme(//11
      isDarkmode: true,
      patternColor: ColorPair(
          primaryColor: Color(0xFF3AFAFA), secondaryColor: Color(0xFF42F7CD)),
      appBarColor:Color(0xFF5bfbfb),
      bnBarColor: Color(0xFF31F7C9),
      name: 'Lightly\nSkyish'),
  ColorAppTheme(//12
      isDarkmode: true,
      patternColor: ColorPair(
          primaryColor: Color(0xFFFFFEFF), secondaryColor: Color(0xFFD7FFFE)),
      appBarColor:Color(0xFFFFFEFF),
      bnBarColor: Color(0xFFe8fffe),
      name: 'Icy Hills'),
  ColorAppTheme(//13
      isDarkmode: true,
      patternColor: ColorPair(
          primaryColor: Color(0xFF6cf63e), secondaryColor: Color(0xFF15ff8e)),
      appBarColor:Color(0xFF78f74e),
      bnBarColor: Color(0xFF00f27d),
      name: 'What...\nGreen?'),
  ColorAppTheme(//14
      isDarkmode: false,
      patternColor: ColorPair(
          primaryColor: Color(0xFF000000), secondaryColor: Color(0xFF000000)),
      appBarColor:Color(0xFF000000),
      bnBarColor: Color(0xFF000000),
      name: 'Simply\nBlack'),
  ColorAppTheme(//15
      isDarkmode: true,
      patternColor: ColorPair(
          primaryColor: Color(0xFFFFEB7E), secondaryColor: Color(0xFFFFFD69)),
      appBarColor:Color(0xFFffee8f),
      bnBarColor: Color(0xFFfffd7a),
      name: 'Notably\nYellow'),
  ColorAppTheme(//16
      isDarkmode: true,
      patternColor: ColorPair(
          primaryColor: Color(0xFFb2f9ff), secondaryColor: Color(0xFFefebbe)),
      appBarColor:Color(0xFFd4fcff),
      bnBarColor: Color(0xFFe8e3a3),
      name: 'Turtly\nSea'),
  ColorAppTheme(//17
      isDarkmode: true,
      patternColor: ColorPair(
          primaryColor: Color(0xFFfbb74c), secondaryColor: Color(0xFFFF5656)),
      appBarColor:Color(0xFFfcc46d),
      bnBarColor: Color(0xFFFF5656),
      name: 'Oof Hot'),
  ColorAppTheme(//18
      isDarkmode: true,
      patternColor: ColorPair(
          primaryColor: Color(0xFFfccb90), secondaryColor: Color(0xFFd57eeb)),
      appBarColor:Color(0xFFfddab1),
      bnBarColor: Color(0xFFd06fe9),
      name: 'Relaxing\nDawn'),
  ColorAppTheme(//19
      isDarkmode: false,
      patternColor: ColorPair(
          primaryColor: Color(0xFF920EE6), secondaryColor: Color(0xFF6304E9)),
      appBarColor:Color(0xFF9b14f1),
      bnBarColor: Color(0xFF5503c8),
      name: 'Even\nPurplier'),
  ColorAppTheme(//20
      isDarkmode: false,
      patternColor: ColorPair(
          primaryColor: Color(0xFFED1C24), secondaryColor: Color(0xFFFF6219)),
      appBarColor:Color(0xFFd61119),
      bnBarColor: Color(0xFFe54900),
      name: 'Tantali\nzing'),
  ColorAppTheme(//21
      isDarkmode: false,
      patternColor: ColorPair(
          primaryColor: Color(0xFF5C3C30), secondaryColor: Color(0xFF422A24)),
      appBarColor:Color(0xFF724b3c),
      bnBarColor: Color(0xFF37231e),
      name: 'Delicious\nBrownie'),
  ColorAppTheme(//22
      isDarkmode: true,
      patternColor: ColorPair(
          primaryColor: Color(0xFFa8ff78), secondaryColor: Color(0xFF78ffd6)),
      appBarColor:Color(0xFFBBFF96),
      bnBarColor: Color(0xFF93FFB9),
      name: 'Greeny\nGorilla'),
  ColorAppTheme(//23
      isDarkmode: true,
      patternColor: ColorPair(
        primaryColor: Color(0xFF00FFA1), secondaryColor: Color(0xFF00FFFF)),
      appBarColor:Color(0xFF55FFC0),
      bnBarColor: Color(0xFF6FF6FF),
      name: 'Cyanic\nTeal'),
  ColorAppTheme(//24
      isDarkmode: true,
      patternColor: ColorPair(
        primaryColor: Color(0xFFc6ffbd), secondaryColor: Color(0xFFffffff)),
      appBarColor:Color(0xFFd5ffce),
      bnBarColor: Color(0xFFf2fff0),
      name: 'Greeny\nEverest'),
];


const appTextTheme = <TextTheme>[
  TextTheme(colorText: Colors.white,      name: "Default"),
  TextTheme(colorText: Color(0xFFFF1744), name: "Pessoa"),
  TextTheme(colorText: Color(0xFFFF2A9F), name: "Lou"),
  TextTheme(colorText: Color(0xFFFF4500), name: "Burgess"),
  TextTheme(colorText: Color(0xFFE86E60), name: "Bowie"),
  TextTheme(colorText: Color(0xFFFFD4F9), name: "Brie"),
  TextTheme(colorText: Color(0xFF651FFF), name: "Matsson"),
  TextTheme(colorText: Color(0xFF2962FF), name: "Isakov"),
  TextTheme(colorText: Color(0xFF54FFFF), name: "Adams"),
  TextTheme(colorText: Color(0xFF006B21), name: "Irwin"),
  TextTheme(colorText: Color(0xFF00E676), name: "Tarkovsky"),
  TextTheme(colorText: Color(0xFF82FFB3), name: "Ebert"),
  TextTheme(colorText: Color(0xFFFFFF4C), name: "Tolkien"),
  TextTheme(colorText: Color(0xFFFFFDBB), name: "Asimov"),
  TextTheme(colorText: Color(0xFFBDBDBD), name: "Kubrick"),
];

class AppTheme {
  final Brightness statusBarTextColor;
  final int actualThemeIndex;
  final int actualTextThemeIndex;
  final bool isDarkmode;

  AppTheme({
    required this.actualThemeIndex,
    required this.actualTextThemeIndex,
    required this.statusBarTextColor,
    required this.isDarkmode,
  })  : assert(actualThemeIndex >= 0, 'Selected color must be greater then 0'),
        assert(actualThemeIndex < appColorTheme.length,
            'Selected color must be less or equal than ${appColorTheme.length - 1}');

  ThemeData getTheme() => ThemeData(
      cupertinoOverrideTheme: const CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      brightness: isDarkmode ? Brightness.dark : Brightness.light,
      fontFamily: 'Quicksand',
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.black,
      // colorSchemeSeed: colorList_old[3],
      appBarTheme: const AppBarTheme(centerTitle: false));

  AppTheme copyWith({
    Brightness? statusBarTextColor,
    int? actualThemeIndex,
    int? actualTextThemeIndex,
    bool? isDarkmode
  }) =>
      AppTheme(
        statusBarTextColor: statusBarTextColor ?? this.statusBarTextColor,
        actualTextThemeIndex: actualTextThemeIndex ?? this.actualTextThemeIndex,
        actualThemeIndex: actualThemeIndex ?? this.actualThemeIndex,  
        isDarkmode: isDarkmode ?? this.isDarkmode,
      );
}
