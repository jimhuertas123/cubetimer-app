import 'package:flutter/material.dart';

import '../icons/custom_icons.dart';

class MenuOptions {
  final int actualOption;

  MenuOptions({required this.actualOption});

  MenuOptions copyWith({int? actualOption, List<MenuItem>? options}) =>
      MenuOptions(actualOption: actualOption ?? this.actualOption);
}

class MenuItem {
  final int id;
  final String title;
  final String subtitle;
  final String? link;
  final IconData icon;
  final List<MenuItem>? children;

  const MenuItem(
      {required this.id,
      required this.title,
      this.subtitle = "none",
      this.link,
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
final Image headerDrawer = Image.asset('assets/icons/menu_header.png',
    fit: BoxFit.fitWidth, width: double.infinity);

///SideMenuBar include every icon, title and link to the page
const appMenuScreensItems = <MenuItem>[
  MenuItem(id: 0, title: 'Cronómetro', link: "/", icon: Icons.timer_outlined
      // children: **NO TIENE childrens**
      ),

  MenuItem(
      id: 1,
      title: 'Entrenamiento',
      // link: "/",**NO TIENE LINK**
      icon: Icons.control_camera_outlined,
      children: <MenuItem>[
        MenuItem(id: 2, title: 'OLL', link: '/oll_training', icon: CubeIcon.oll_black),
        MenuItem(id: 3, title: 'PLL', link: "/pll_training", icon: CubeIcon.pll_black),
      ]),
  //Algorithm options
  MenuItem(
      id: 4,
      title: 'Algoritmos',
      // link: "/",**NO TIENE LINK**
      icon: Icons.library_books_outlined,
      children: <MenuItem>[
        MenuItem(id: 5, title: 'OLL', link: "/oll_algorithms", icon: CubeIcon.oll_black),
        MenuItem(id: 6, title: 'PLL', link: "/pll_algorithms", icon: CubeIcon.pll_black),
      ]),
];

const appMenuOthers = <MenuItem>[
  MenuItem(
    id: 8,
    title: 'Exportar/Importar',
    // link: "/",**NO TIENE LINK**
    icon: Icons.control_camera_outlined,
  ),
  MenuItem(
    id: 9,
    title: 'Tema de la Aplicación',
    // link: "/",**NO TIENE LINK**
    icon: Icons.folder_outlined,
  ),
  MenuItem(
    id: 10,
    title: 'Esquema de Colores',
    // link: "/",**NO TIENE LINK**
    icon: Icons.format_paint_outlined,
  ),
];

const appMenufinalItems = <MenuItem>[
    MenuItem(
    id: 11,
    title: 'Ajustes',
    link: "/settings",
    icon: Icons.settings_outlined,
  ),
  MenuItem(
    id: 12,
    title: 'Donar',
    // link: "/",**NO TIENE LINK**
    icon: Icons.favorite_outline,
  ),
  MenuItem(
    id: 13,
    title: 'Acerca de y comentarios',
    link: "/about",
    icon: Icons.help_outline,
  ),
];
