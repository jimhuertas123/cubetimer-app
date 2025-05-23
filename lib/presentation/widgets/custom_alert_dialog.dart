import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  final String tittle;
  final List<Widget>? actions;
  final BuildContext context;
  final List<Widget> content;
  final double fontTittleSize;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsets insetPadding;
  final Widget tittleContent;
  final double? height;
  final bool enableHeight;

  const CustomAlertDialog(
      {super.key,
      required this.content,
      required this.context,
      required this.enableHeight,
      this.tittle = "",
      this.actions,
      this.fontTittleSize = 20,
      this.contentPadding,
      this.insetPadding = EdgeInsets.zero,
      this.height,
      this.tittleContent = const SizedBox.shrink()});

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      insetPadding: widget.insetPadding,
      contentPadding: const EdgeInsets.only(top: 5.0, bottom: 0),
      titlePadding: const EdgeInsets.only(top: 10),
      title: widget.tittle.isEmpty
          ? widget.tittleContent
          : Text(
              widget.tittle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: widget.fontTittleSize,
                  color: Colors.black),
            ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      actionsPadding: EdgeInsets.zero,
      actions: widget.actions,
      content: Builder(builder: (context) {
        return Container(
          padding: widget.contentPadding,
          height: widget.enableHeight 
            ? (MediaQuery.of(context).size.height > 500 
              ? widget.height ?? 472 
              : 290) 
            : null,
          width: (MediaQuery.of(context).size.width < 400)
              ? MediaQuery.of(context).size.width - 50
              : 400,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ListBody(children: widget.content),
          ),
        );
      }),
    );
  }
}
