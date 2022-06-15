import 'package:acti_barrio_flutter/src/widgets/custom_buttom_disable_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import '../provider/filtros_provider.dart';

class CustomBottonBar extends StatefulWidget {
  const CustomBottonBar({Key? key}) : super(key: key);

  @override
  State<CustomBottonBar> createState() => _CustomBottonBarState();
}

class _CustomBottonBarState extends State<CustomBottonBar> {
  @override
  void initState() {
    getFiltros();
    super.initState();
  }
  //TODO:Cargar filtros de base de datos

  @override
  Widget build(BuildContext context) {
    final filtrosProviders = Provider.of<FiltrosProviders>(context);
    final filtros = filtrosProviders.filtros;
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
        children: filtros.map((e) {
          print(e.nombre);
          return SpeedDialChild(
              backgroundColor: Colors.transparent,
              child: CustomButtonColor(
                nombreFiltro: e.nombre,
                assetImage: e.imagen,
              ));
        }).toList(),
      ),
    );
  }

  void getFiltros() async {
    final filtrosProviders =
        Provider.of<FiltrosProviders>(context, listen: false);
    await filtrosProviders.getFiltros();
  }
}
