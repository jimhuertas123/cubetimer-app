import 'package:flutter/material.dart';

class MenuOptions {
  final int actualOption;
  final List<MenuItem> options;

  MenuOptions({required this.actualOption, required this.options});

  MenuOptions copyWith({int? actualOption, List<MenuItem>? options}) =>
      MenuOptions(
          actualOption: actualOption ?? this.actualOption,
          options: options ?? this.options);
}

class MenuItem {
  final int id;
  final String title;
  final String subtitle;
  final String link;
  final IconData icon;
  final List<MenuItem>? children;

  const MenuItem(
      {required this.id,
      required this.title,
      this.subtitle = "none",
      required this.link,
      required this.icon,
      this.children});
}

///VARIABLES...
//extras icons
final Image iconOll = Image.asset(
  'assets/icons/oll_black.png',
  color: Colors.black54,
  fit: BoxFit.cover,
  width: 20,
  height: 20,
);
final Image iconPll = Image.asset(
  'assets/icons/pll_black.png',
  color: Colors.black54,
  fit: BoxFit.cover,
  width: 20,
  height: 20,
);
final Image headerDrawer = Image.asset('assets/icons/menu_header.png');

///SideMenuBar include every iconm, title and link to the page
const appMenuItems = <MenuItem>[
  MenuItem(id:0, title: 'Cronómetro', link: "/", icon: Icons.timer_outlined),

  MenuItem(
      id:1,
      title: 'Entrenamiento',
      link: "/",
      icon: Icons.control_camera_outlined,
      children: <MenuItem>[MenuItem(id: 0, title: 'OLL', link: '/', icon: Icons.abc)]),
  // MenuItem(
  //   title: 'PLL',
  //   link: "/oll_training",
  //   icon:
  // ),

  //Algorithms Option
  // MenuItem(
  //   title: 'OLL',
  //   link: "/oll_algorithms",
  //   icon: Icons.control_camera_outlined,
  // ),
  // MenuItem(
  //   title: 'PLL',
  //   link: "/pll_algorithms",
  //   icon: Icons.control_camera_outlined,
  // ),

  MenuItem(
    id:2,
    title: 'Exportar/Importar',
    link: "/",
    icon: Icons.control_camera_outlined,
  ),

  MenuItem(
    id:3,
    title: 'Tema de la Aplicación',
    link: "/",
    icon: Icons.folder_outlined,
  ),

  MenuItem(
    id:4,
    title: 'Esquema de Colores',
    link: "/",
    icon: Icons.format_paint_outlined,
  ),

  MenuItem(
    id:5,
    title: 'Ajustes',
    link: "/settings",
    icon: Icons.settings_outlined,
  ),

  MenuItem(
    id:6,
    title: 'Donar',
    link: "/",
    icon: Icons.favorite_outline,
  ),

  MenuItem(
    id:7,
    title: 'Acerca de y comentarios',
    link: "/about",
    icon: Icons.help_outline,
  ),
];
