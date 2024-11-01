import 'package:cube_timer_2/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menuOptionsNotifierProvider = StateNotifierProvider<MenuOptionsNotifier, MenuOptions>(
  (ref) => MenuOptionsNotifier(),
);

class MenuOptionsNotifier extends StateNotifier<MenuOptions> {
  MenuOptionsNotifier(): super(MenuOptions(actualOption: 0, options: appMenuItems));

  void changeOption(int newMenuOption) {
    state = state.copyWith(
      actualOption: newMenuOption
    );
  }
}
