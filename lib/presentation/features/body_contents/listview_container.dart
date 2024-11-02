import 'package:cube_timer_2/presentation/custom_scrolls/scroll_elastic.dart';
import 'package:cube_timer_2/presentation/providers/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageViewContainers extends ConsumerWidget {
  final Animation<double> stretchAnimation;
  final PageController pageController;
  // final WidgetRef ref;
  const PageViewContainers({
    super.key,
    required this.stretchAnimation,
    required this.pageController,
    // required this.ref
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
      
      onPageChanged: (index) {
        ref.read(pageIndexProviderInt.notifier).setPageIndex(index);
      },
      controller: pageController,
      scrollDirection: Axis.horizontal,
      physics: const ElasticScrollPhysics(),
      itemCount: 3,
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
                child: Center(
                  child: Text(
                    'Page $index',
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
