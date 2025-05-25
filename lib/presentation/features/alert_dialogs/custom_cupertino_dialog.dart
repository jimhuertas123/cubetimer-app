import 'dart:ui';
import 'package:flutter/cupertino.dart';

class CustomCupertinoDialog extends StatefulWidget {
  final Widget title;
  final List<Widget> content;

  const CustomCupertinoDialog({super.key, required this.title, required this.content});

  @override
  State<CustomCupertinoDialog> createState() => _CustomCupertinoDialogState();
}

class _CustomCupertinoDialogState extends State<CustomCupertinoDialog> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: CupertinoTheme(
          data: CupertinoTheme.of(context).copyWith(
            brightness: Brightness.light,
          ),
          child: CupertinoAlertDialog(
            title: widget.title,
            content:  Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.content,
            ),
            actions: <Widget>[
              // CupertinoDialogAction(
              //   child: Text('Cancel'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              // CupertinoDialogAction(
              //   child: Text('OK'),
              //   onPressed: () {
              //     // Handle OK action
              //   },
              // ),
            ],
          ),
        ));
  }
}
