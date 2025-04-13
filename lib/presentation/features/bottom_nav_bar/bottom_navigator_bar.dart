import 'package:cube_timer_2/presentation/providers/menu_controller_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomBottomNavigationBar extends ConsumerStatefulWidget {
  final Color backgroundColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final bool isTimerRunning;
  final PageController pageController;
  final void Function(int) onTap;
  const CustomBottomNavigationBar(
      {super.key,
      required this.backgroundColor,
      required this.activeIconColor,
      required this.inactiveIconColor,
      required this.pageController,
      required this.isTimerRunning,
      required this.onTap});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends ConsumerState<CustomBottomNavigationBar> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    ));
  }

  @override
  Widget build(BuildContext context) {
    int actualIndexPage = ref.watch(pageIndexProviderInt);

    if (widget.isTimerRunning) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    return Theme.of(context).platform == TargetPlatform.iOS
      ? SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: IosTabBar(
              backgroundColor: widget.backgroundColor,
              activeIconColor: widget.activeIconColor,
              inactiveIconColor: widget.inactiveIconColor,
              actualIndexPage: actualIndexPage,
              pageController: widget.pageController,
              onTap: widget.onTap
            ),
        ),
      )
      : SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: AndroidBottomNavBar(
              backgroundColor: widget.backgroundColor,
              activeIconColor: widget.activeIconColor,
              inactiveIconColor: widget.inactiveIconColor,
              pageController: widget.pageController,
              actualIndexPage: actualIndexPage,
              onTap: widget.onTap
            ),
        ),
      );
  }
}


///IOS bottom navigation bar
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
              color: Colors.black.withAlpha(70),
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

///Android bottom navigation bar
/// A custom bottom navigation bar for Android that includes three items: Home, Business, and School.
/// 
/// This widget is a stateful widget that takes several parameters to customize its appearance and behavior:
/// 
/// - `backgroundColor`: The background color of the bottom navigation bar.
/// - `activeIconColor`: The color of the icon when it is selected.
/// - `inactiveIconColor`: The color of the icon when it is not selected.
/// - `actualIndexPage`: The index of the currently selected page.
/// - `pageController`: A controller to manage the pages.
/// - `onTap`: A callback function that is called when an item is tapped.
/// 
/// The bottom navigation bar has a rounded top border and a shadow effect.
class AndroidBottomNavBar extends StatefulWidget {
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
  State<AndroidBottomNavBar> createState() => _AndroidBottomNavBarState();
}

class _AndroidBottomNavBarState extends State<AndroidBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
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