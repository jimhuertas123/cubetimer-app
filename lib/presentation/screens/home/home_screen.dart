import 'package:cube_timer_2/presentation/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final username = ref.watch(userNameProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // systemNavigationBarColor: Colors.red,
        statusBarColor: Colors.red,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light
      ),
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
          // backgroundColor: Colors.red,
          title: const Text('State Provider'),
        ),
        body: Center(
            child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            IconButton(
              // icon: const Icon( Icons.light_mode_outlined, size: 100 ),
              // icon: (isDarkMode)
              //     ? const Icon(Icons.dark_mode_outlined, size: 100)
              icon: const Icon(Icons.light_mode_outlined, size: 100),
              onPressed: () {
                // ref.read(darkModeProvider.notifier).toggleDarkMode();
              },
            ),
            Text('$username', style: TextStyle(fontSize: 25)),
            TextButton.icon(
              icon: const Icon(
                Icons.add,
                size: 50,
              ),
              label: Text('$counter', style: const TextStyle(fontSize: 100)),
              onPressed: () {
                ref.read(counterProvider.notifier).increaseByOne();
              },
            ),
            const Spacer(flex: 2),
          ],
        )),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Nombre aleatorio'),
          icon: const Icon(Icons.refresh_rounded),
          onPressed: () {
            ref.read(userNameProvider.notifier).changeName('Medidas');
          },
        ),
      ),
    );
  }
}
