import 'package:cube_timer_2/config/config.dart';
import 'package:flutter/material.dart';

class ThemeContainer extends StatelessWidget {
  final ColorPair colors;
  final String tittle;
  final bool isSelected;
  final Color backgroundTextColor;
  final void Function()? onTap;

  const ThemeContainer(
      {super.key,
      required this.isSelected,
      required this.colors,
      required this.onTap,
      required this.backgroundTextColor,
      required this.tittle});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min, // Alinea el contenido al centro
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 40.0, // Ancho del rectángulo
              height: 63.0, // Alto del rectángulo
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colors.primaryColor, colors.secondaryColor], // Colores del gradiente
                  begin:
                      Alignment.topCenter, // Inicio del gradiente desde arriba
                  end: Alignment.bottomCenter, // Fin del gradiente hacia abajo
                ),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.black, // Color del borde (en este caso, negro)
                  width: 0.5, // Ancho del borde
                ),
              ),
            ),
          ),
          const SizedBox(height: 5.0), // Espacio entre el rectángulo y el texto
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            width: 62,
            decoration: BoxDecoration(
              color: backgroundTextColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              decoration: (isSelected) 
                ? BoxDecoration(
                  color: const Color.fromRGBO(255,239,143,1),
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(color: const Color.fromRGBO(255,236,80, 1), width: 1.0))
                : null,
              padding: const EdgeInsets.only(top: 4),
              width: 8.0,
              height: 38,
              child: Text(
                tittle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Quicksand",
                  color: Colors.black,
                  fontSize: 11.0
                ),
              ),
            ),
          ),
        ],
      );
}
