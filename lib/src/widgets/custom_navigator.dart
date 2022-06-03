import 'package:acti_barrio_flutter/src/widgets/custom_buttom_disable_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CustomBottonBar extends StatefulWidget {
  const CustomBottonBar({Key? key}) : super(key: key);

  @override
  State<CustomBottonBar> createState() => _CustomBottonBarState();
}

class _CustomBottonBarState extends State<CustomBottonBar> {
  //TODO:Cargar filtros de base de datos
  Map tempButtons = {
    'images/actibarrio_deporte.png': 'deporte',
    'images/actibarrio_arte.png': 'arte',
    'images/actibarrio_cursos.png': 'cursos',
    'images/actibarrio_sociales.png': 'sociales',
    'images/actibarrio_otros.png': 'otros',
    'images/actibarrio_bici.png': 'bici',
    'images/actibarrio_mercado.png': 'mercado',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SpeedDial(
        spacing: 10.0,
        useRotationAnimation: false,
        activeChild: const Icon(
          Icons.close,
          size: 20.0,
        ),
        overlayOpacity: 0.5,
        overlayColor: Colors.grey,
        direction: SpeedDialDirection.up,
        buttonSize: const Size(65, 65),
        curve: Curves.elasticIn,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 100),
        activeBackgroundColor: Colors.grey[800],
        child: const Center(
          child: Image(
            image: AssetImage('images/filtro.png'),
          ),
        ),
        children: tempButtons.keys.map((e) {
          return SpeedDialChild(
              backgroundColor: Colors.transparent,
              child: CustomButtonColor(
                nombreFiltro: tempButtons[e],
                assetImage: e,
              ));
        }).toList(),
      ),
    );
  }
}
