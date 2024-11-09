import 'package:go_router/go_router.dart';
import 'package:cube_timer_2/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen()  
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
