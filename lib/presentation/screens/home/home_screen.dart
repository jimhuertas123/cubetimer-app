import 'dart:io';

import 'package:flutter/material.dart';

import '../screens.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return const IosHomeScreen();
    } else if (Platform.isAndroid) {
      return const AndroidHomeScreen();
    } else {
      return const AndroidHomeScreen();
    }
  }
}