import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cube_timer_2/presentation/widgets/widgets.dart';
import 'package:cube_timer_2/presentation/providers/menu_options.dart';
import 'package:cube_timer_2/config/config.dart';

class DrawerHome extends ConsumerWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuOptions = ref.watch(menuOptionsNotifierProvider).options;
    final int actualOption =
        ref.watch(menuOptionsNotifierProvider).actualOption;
    return SafeArea(
      top: false,
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
            SafeArea(
              left: false,
              child: SizedBox(
                height: 178,
                child: headerDrawer,
              ),
            ),

            CustomTile(
                title: "asdasd",
                initiallyExpanded: true,
                trailing: const Icon(Icons.arrow_downward_outlined),
                children: [
                  _listTileDrawer(12, const Icon(Icons.abc_rounded), "title", false)
                ]),

            ...menuOptions.map((element) {
              return (element.children == null)
                  ? (actualOption == element.id)
                      ? _listTileDrawer(
                            element.id, element.icon, element.title, true)
                      : _listTileDrawer(
                          element.id, element.icon, element.title, false)
                  : _listTileExpandable(
                      context, element.icon, element.title, element.children!);
            }).toList(),

            // Container(
            //   padding: const EdgeInsets.all(0),
            //   child: _listTileDrawer(
            //       Icons.timer_outlined,
            //       // iconPll,
            //       'Cronómetro',
            //       true),
            // ),
            // Theme(
            //   data:
            //       Theme.of(context).copyWith(dividerColor: Colors.transparent),
            //   child: Container(
            //     margin: EdgeInsets.zero,
            //     padding: EdgeInsets.zero,

            //     // color: Colors.red,
            //     // height: 20.0,
            //     child: ExpansionTile(
            //       shape: const Border(),
            //       title: Text("xd"),
            //       tilePadding: EdgeInsets.zero,
            //       children: [
            //         _listTileDrawer(
            //           Icons.folder_outlined,
            //           'Exportar/Importar',
            //           false,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // const Divider(color: Colors.grey),
            // const Padding(
            //     padding: EdgeInsets.only(left: 15.0, top: 8.0, bottom: 15.0),
            //     child: Text('Otros',
            //         style:
            //             TextStyle(fontFamily: 'Arial', color: Colors.black87))),
            // _listTileDrawer(
            //   Icons.folder_outlined,
            //   'Exportar/Importar',
            //   false,
            // ),
            // _listTileDrawer(
            //     Icons.palette_outlined, 'Tema de la Aplicación', false),
            // _listTileDrawer(
            //     Icons.format_paint_outlined, 'Esquema de colores', false),
            // const Divider(color: Colors.grey),
            // _listTileDrawer(Icons.settings_outlined, 'Ajustes', false),
            // _listTileDrawer(Icons.favorite_outline, 'Donar', false),
            // _listTileDrawer(
            //     Icons.help_outline, 'Acerca de y comentarios', false),
            // const SizedBox(height: 25)
          ],
        ),
      ),
    );
  }

  _listTileExpandable(
      BuildContext context, icon, String title, List<MenuItem> items) {
    return ListTileTheme(
      child: ExpansionTile(
        tilePadding: const EdgeInsets.only(right: 20.0),
        title: Text(title,
            style: const TextStyle(fontFamily: 'Arial', fontSize: 15.0)),
        leading: (icon is IconData)
            ? Container(
                // height: 53,
                padding: const EdgeInsets.only(left: 16, right: 0),
                color: Colors.red,
                child: Icon(icon, color: Colors.black54))
            : icon,
        // shape: const Border(),
        // tilePadding: EdgeInsets.zero,
        children: const [],
      ),
    );
  }

  _listTileDrawer(int id, icon, String title, bool selected) {
    return ListTile(
      key: Key(id.toString()),
      selected: selected,
      selectedColor: Colors.blue,
      // selectedTileColor: Colors.red,
      title: Text(
            title,
            style: const TextStyle(fontFamily: 'Arial', fontSize: 15.0)),
      leading: (icon is IconData) 
                ? Icon(icon, color: Colors.black54) 
                : icon,
      dense: true,
      visualDensity: const VisualDensity(horizontal: 4),
      //visualDensity: const VisualDensity(vertical: -2),
      onTap: () {},
    );
  }

  _listItem(dynamic icon, String name) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          // color: Colors.yellow,
          padding: (icon is IconData)
              ? const EdgeInsets.only(left: 5.0)
              : const EdgeInsets.only(left: 31.0, bottom: 12.0),
          width: 50,
          height: (icon is IconData) ? 45 : 42,
          child: (icon is IconData)
              ? Icon(icon, size: 26.0, color: Colors.black54)
              : icon,
        ),
        Container(
          padding: (icon is IconData)
              ? const EdgeInsets.only(left: 21.0)
              : const EdgeInsets.only(left: 35.0),
          child: (icon is IconData)
              ? Text(
                  name,
                  style: const TextStyle(
                      fontFamily: 'Arial',
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0),
                )
              : Text(name),
        )
      ],
    );
  }
}
