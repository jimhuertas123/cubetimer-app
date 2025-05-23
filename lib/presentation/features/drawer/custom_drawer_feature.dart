import 'package:cube_timer_2/presentation/providers/providers.dart';
import 'package:cube_timer_2/presentation/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:cube_timer_2/config/config.dart';

class DrawerHome extends ConsumerWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int selectedOption =
        ref.watch(menuOptionsNotifierProvider).actualOption;
    return SafeArea(
      top: false,
      child: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
        ),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
            SizedBox(
              height: 148,
              child: headerDrawer,
            ),
            const SizedBox(height: 5),
            ...appMenuScreensItems.map((element) {
              return (element.children == null)
                  ? (selectedOption == element.id)
                      ? _listTileDrawer(
                          element.id, element.icon, element.title, true, ref, context)
                      : _listTileDrawer(
                          element.id, element.icon, element.title, false, ref, context)
                  : _listTileExpandable(context, element.id, element.icon,
                      element.title, element.children!, selectedOption, ref);
            }),
            const Divider(color: Color.fromRGBO(158, 158, 158, 0.4)),
            const Padding(
                padding: EdgeInsets.only(left: 14.0, top: 6.0, bottom: 20.0),
                child: Text('Otros',
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey))),
            ...appMenuOthers.map((element) {
              return (selectedOption == element.id)
                  ? _listTileDrawer(
                      element.id, element.icon, element.title, true, ref, context)
                  : _listTileDrawer(
                      element.id, element.icon, element.title, false, ref, context);
            }),
            const Divider(color: Color.fromRGBO(158, 158, 158, 0.4)),
            ...appMenufinalItems.map((element) {
              return (selectedOption == element.id)
                  ? _listTileDrawer(
                      element.id, element.icon, element.title, true, ref, context)
                  : _listTileDrawer(
                      element.id, element.icon, element.title, false, ref, context);
            }),
            const SizedBox(height: 5)
          ],
        ),
      ),
    );
  }

  _listTileExpandable(BuildContext context, int id, IconData icon, String title,
      List<MenuItem> items, int selectedOption, WidgetRef ref) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          // color: const Color.fromRGBO(244, 67, 54, 0.5),
        ),
        child: ExpansionTile(
            initiallyExpanded: id == 1
                ? selectedOption == 2 || selectedOption == 3
                    ? true
                    : false
                : id == 4
                    ? selectedOption == 5
                        ? true
                        : false
                    : false,
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            visualDensity: const VisualDensity(horizontal: -4, vertical: -3.5),
            tilePadding: const EdgeInsets.only(left: 8),
            title: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Arial',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            leading: Container(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: Icon(icon, color: Colors.black54)),
            children: <Widget>[
              const SizedBox(height: 3),
              ...items
                  .map((item) => CustomListTile(
                        selected: selectedOption == item.id,
                        icon: item.icon,
                        title: item.title,
                        key: Key(item.id.toString()),
                        onTap: () async {
                          if (item.id != selectedOption) {
                            ref
                                .read(menuOptionsNotifierProvider.notifier)
                                .changeOption(item.id);
                          }
                          Navigator.of(context).pop();
                        },
                      ))
            ]),
      ),
    );
  }

  _listTileDrawer(int id, icon, String title, bool selected, WidgetRef ref, BuildContext context) {
    final int selectedOption =
        ref.watch(menuOptionsNotifierProvider).actualOption;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: selected
              ? const Color.fromRGBO(96, 164, 219, 0.13)
              : Colors.transparent),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: const EdgeInsets.only(left: 8.0),
        key: Key(id.toString()),
        selected: selected,
        selectedColor: const Color(0xFF4aa8ef),
        textColor: Colors.black87,
        title: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Arial',
                  fontSize: 15.0)),
        ),
        leading: Icon(
          icon,
          color: selected ? const Color(0xFF4aa8ef) : const Color(0xff767676),
        ),
        dense: true,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -3),
        onTap: () {
          if(id == 9){
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  enableHeight: true,
                  tittle: 'App theme',
                  fontTittleSize: 20.0,
                  context: context,
                  insetPadding: const EdgeInsets.symmetric(horizontal: 30),
                  contentPadding: const EdgeInsets.only(
                      right: 0, left: 0, top: 15, bottom: 0),
                  content: const <Widget>[ThemeChange()]
              )
            );
          }else{
            Navigator.of(context).pop();
          }
          if (id == 0 && selectedOption != 0) {
            ref.read(menuOptionsNotifierProvider.notifier).changeOption(id);
          }
        },
      ),
    );
  }
}
