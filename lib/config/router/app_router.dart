import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cube_timer_2/presentation/screens/screens.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        if (Platform.isIOS) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return MaterialWithModalsPageRoute(
                builder: (context) => child,
                settings: RouteSettings(name: state.name),
              ).buildPage(context, animation, secondaryAnimation);
            },
          );
        } else {
          return MaterialPage(
            key: state.pageKey,
            child: const HomeScreen(),
          );
        }
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen()  
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen()  
    ),
  ]);
