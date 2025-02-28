import 'package:cube_timer_2/presentation/custom_scrolls/scroll_elastic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class PageViewContainers extends ConsumerWidget {
  final Animation<double> stretchAnimation;
  final PageController pageController;
  final List<Widget> pages;

  const PageViewContainers({
    super.key,
    required this.stretchAnimation,
    required this.pageController,
    required this.pages,
  })  : assert(pages.length == 3, 'The pages list must contain exactly 3 widgets.');

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bool isTimerRunning = ref.watch(cronometerRunnerProvider);

    return PageView.builder(
      onPageChanged: (index) {
        ref.read(pageIndexProviderInt.notifier).setPageIndex(index);
      },
      controller: pageController,
      scrollDirection: Axis.horizontal,
      physics: isTimerRunning ? const NeverScrollableScrollPhysics() : const ElasticScrollPhysics(),
      itemCount: pages.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: stretchAnimation,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()..scale(stretchAnimation.value, 1.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent,
                child: pages[index],
              ),
            );
          },
        );
      },
    );
  }
}
