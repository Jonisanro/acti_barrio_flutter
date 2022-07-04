import 'package:acti_barrio_flutter/src/provider/markers_provider.dart';
import 'package:acti_barrio_flutter/src/widgets/custom_buttom_disable_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class CustomBottonBar extends StatefulWidget {
  const CustomBottonBar({Key? key}) : super(key: key);

  @override
  State<CustomBottonBar> createState() => _CustomBottonBarState();
}

class _CustomBottonBarState extends State<CustomBottonBar> {
  @override
  void initState() {
    super.initState();
  }
  //TODO:Cargar filtros de base de datos

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final markersProviders = Provider.of<MarkersProviders>(context);
    final filtros = markersProviders.filters;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SpeedDial(
        useRotationAnimation: false,
        activeChild: const Icon(
          Icons.close,
          size: 20.0,
        ),
        overlayOpacity: 0.5,
        overlayColor: Colors.grey,
        direction: SpeedDialDirection.up,
        buttonSize: const Size(60, 60),
        curve: Curves.elasticIn,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 100),
        activeBackgroundColor: Colors.grey[800],
        child: const Center(
          child: Image(
            image: AssetImage('images/filtro.png'),
          ),
        ),
        children: filtros.map((e) {
          return SpeedDialChild(
              backgroundColor: Colors.transparent,
              child: CustomButtonColor(
                filtro: e,
              ));
        }).toList(),
      ),
    );
  }
}
