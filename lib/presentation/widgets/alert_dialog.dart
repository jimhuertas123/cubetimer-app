import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String tittle;
  final Widget? actions;
  final BuildContext context;
  final List<Widget> content;
  final double fontTittleSize;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsets insetPadding;

  const CustomAlertDialog(
      {super.key,
      required this.content,
      required this.context,
      this.actions,
      this.fontTittleSize = 20,
      this.tittle = 'Tittle Example',
      this.contentPadding,
      this.insetPadding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),//const Color.fromARGB(255, 235, 235, 235),
      insetPadding: insetPadding,
      contentPadding: const EdgeInsets.only(top: 5.0),
      titlePadding: const EdgeInsets.only(top: 10),
      title: Text(
        tittle,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: fontTittleSize, color: Colors.black),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      actions: const <Widget>[],
      content: Builder(builder: (context) {
        return Container(
          padding: contentPadding,
          width: (MediaQuery.of(context).size.width < 400)
              ? MediaQuery.of(context).size.width - 50
              : 400,
          //height its dynamic :D
          child: SingleChildScrollView(
            child: ListBody(children: content),
          ),
        );
      }),
    );
  }
}