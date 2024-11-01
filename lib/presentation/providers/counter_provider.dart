// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:cube_timer_v2/config/config.dart';

part 'counter_provider.g.dart';

@riverpod
class Counter extends _$Counter {
  @override
  int build() => 1;

  void increaseByOne() {
    state++;
  }
}

@riverpod
class UserName extends _$UserName {
  @override
  String build() => 'Jim Huertas';

  void changeName(String name) {
    state = name;
  }
}
