
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final bool selected;
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        customBorder: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          1,
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: selected
                  ? const Color.fromRGBO(96, 164, 219, 0.13)
                  : Colors.transparent),
          padding: const EdgeInsets.only(bottom: 6.5, top: 6.5, left: 12.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  icon,
                  color: selected
                      ? const Color(0xFF4aa8ef)
                      : const Color(0xff767676),
                  size: 20.0, // Ajusta el tamaño del icono
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 26.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: selected
                            ? const Color(0xFF4aa8ef)
                            : const Color(0xff767676),
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
