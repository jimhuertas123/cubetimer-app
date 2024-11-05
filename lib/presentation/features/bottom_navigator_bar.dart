import 'package:cube_timer_2/presentation/providers/menu_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  final Color backgroundColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final PageController pageController;
  final void Function(int) onTap;
  const CustomBottomNavigationBar(
      {super.key,
      required this.backgroundColor,
      required this.activeIconColor,
      required this.inactiveIconColor,
      required this.pageController,
      required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) { 
    int actualIndexPage = ref.watch(pageIndexProviderInt);

    return Theme.of(context).platform == TargetPlatform.iOS
        ? IosTabBar(
            backgroundColor: backgroundColor,
            activeIconColor: activeIconColor,
            inactiveIconColor: inactiveIconColor,
            actualIndexPage: actualIndexPage,
            pageController: pageController,
            onTap: onTap
          )
        : AndroidBottomNavBar(
            backgroundColor: backgroundColor,
            activeIconColor: activeIconColor,
            inactiveIconColor: inactiveIconColor,
            pageController: pageController,
            actualIndexPage: actualIndexPage,
            onTap: onTap
          );
  }
}

class IosTabBar extends StatefulWidget {
  final Color backgroundColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final int actualIndexPage;
  final PageController pageController;
  final void Function(int) onTap;
  const IosTabBar(
      {super.key,
      required this.backgroundColor,
      required this.activeIconColor,
      required this.inactiveIconColor,
      required this.actualIndexPage,
      required this.pageController,
      required this.onTap});

  @override
  State<IosTabBar> createState() => _IosTabBarState();
}

class _IosTabBarState extends State<IosTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0.1,
              blurRadius: 4.7,
              offset: const Offset(0, 0),
            ),
          ]),
      height: 38,
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: CupertinoTabBar(
            currentIndex: widget.actualIndexPage,
            backgroundColor: widget.backgroundColor,
            onTap: widget.onTap,
            iconSize: 24,
            activeColor: widget.activeIconColor,
            inactiveColor: widget.inactiveIconColor,
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: const Icon(CupertinoIcons.timer))),
              BottomNavigationBarItem(
                  icon: Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: const Icon(CupertinoIcons.square_list))),
              BottomNavigationBarItem(
                  icon: Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: const Icon(CupertinoIcons.graph_square))),
            ],
          )),
    );
  }
}

class AndroidBar extends ConsumerStatefulWidget {
  const AndroidBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AndroidBarState();
}

class _AndroidBarState extends ConsumerState<AndroidBar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AndroidBottomNavBar extends ConsumerStatefulWidget {
  final Color backgroundColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final int actualIndexPage;
  final PageController pageController;
  final void Function(int) onTap;
  const AndroidBottomNavBar(
      {super.key,
      required this.backgroundColor,
      required this.activeIconColor,
      required this.inactiveIconColor,
      required this.actualIndexPage,
      required this.pageController,
      required this.onTap});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AndroidBottomNavBarState();
}

class _AndroidBottomNavBarState extends ConsumerState<AndroidBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 0.1,
            blurRadius: 4.7,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      height: 40,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          selectedItemColor: widget.activeIconColor,
          unselectedItemColor: widget.inactiveIconColor,
          currentIndex: widget.actualIndexPage,
          backgroundColor: widget.backgroundColor,
          onTap: widget.onTap,
          iconSize: 24.0,
          selectedFontSize: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.timer_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timeline_outlined),
              label: 'School',
            ),
          ],
        ),
      ),
    );
  }
}
