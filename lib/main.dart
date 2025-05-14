import 'package:cube_timer_2/database/data/database_helper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cube_timer_2/presentation/providers/theme_provider.dart';
import 'package:cube_timer_2/config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the database
  final dbHelper = DatabaseHelper();
  await dbHelper.database;
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTheme appTheme = ref.watch(themeNotifierProvider);
    return MaterialApp.router(
      title: 'Cube Timer',
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
      routerConfig: appRouter);
  }
}
