import 'package:flutter/material.dart';

class TextThemeContainer extends StatelessWidget {
  final Color borderColor;
  final bool isSelected;
  final Color textColor;
  final Color color;
  final String name;
  final void Function()? onTap;

  const TextThemeContainer(
      {super.key,
      required this.name,
      required this.textColor,
      required this.color,
      required this.borderColor,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(left: 6, right: 12, top: 10),
          width: 55,
          height: 47,
          child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                  width: 0.7,
                ),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent,
              ),
              child: Center(
                  child: Text('Aa',
                      style: TextStyle(
                          color: color,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w500)))),
        ),
      ),
      const SizedBox(height: 6.0),
      FittedBox(
        fit: BoxFit.fitHeight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          margin: const EdgeInsets.only(bottom: 5),
          alignment: Alignment.center,
          decoration: (isSelected)
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: const Color.fromRGBO(255, 235, 62, 1)
                  ),
                  color: const Color.fromRGBO(255, 239, 143, 1),
                )
              : null,
          child: Text(name,
              style: TextStyle(
                color: (isSelected) ? Colors.black : textColor,
                fontSize: 11.0,
              )))),
    ]);
  }
}
