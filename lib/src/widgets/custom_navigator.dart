import 'package:acti_barrio_flutter/src/widgets/custom_buttom_disable_color.dart';
import 'package:flutter/material.dart';

class CustomBottonBar extends StatefulWidget {
  const CustomBottonBar({Key? key}) : super(key: key);

  @override
  State<CustomBottonBar> createState() => _CustomBottonBarState();
}

class _CustomBottonBarState extends State<CustomBottonBar> {
  Map tempButtons = {
    'images/actibarrio_deporte.png': 'Deporte',
    'images/actibarrio_arte.png': 'Arte',
    'images/actibarrio_cursos.png': 'Cursos',
    'images/actibarrio_sociales.png': 'Sociales',
    'images/actibarrio_otros.png': 'Otros',
  };

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.1,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color.fromARGB(255, 35, 17, 35)),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: tempButtons.keys.map((e) {
          return CustomButtonColor(
            nombreFiltro: tempButtons[e],
            assetImage: e,
          );
        }).toList(),
      ),
    );
  }
}
