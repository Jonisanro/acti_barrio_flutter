import 'package:acti_barrio_flutter/src/provider/markers_provider.dart';
import 'package:acti_barrio_flutter/src/widgets/custom_buttom_disable_color.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowDialogFiltros {
  alerta(BuildContext context) {
    final markersProviders =
        Provider.of<MarkersProviders>(context, listen: false);
    final filtros = markersProviders.filters;
    final size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            width: size.width * 0.85,
            height: size.height * 0.7,
            child: Stack(children: [
              AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                actions: <Widget>[
                  const Divider(
                    thickness: 1.0,
                    height: 2.0,
                  ),
                  CupertinoDialogAction(
                    child: const Text(
                      'Cerrar',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                          fontSize: 18.0,
                          height: 1.3),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
                content: SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      padding: const EdgeInsets.all(0.0),
                      crossAxisCount: 3,
                      children: filtros.map((e) {
                        return SizedBox(child: CustomButtonColor(filtro: e));
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, -0.95),
                child: Image(
                  width: size.width * 0.2,
                  height: size.height * 0.2,
                  image: const AssetImage('images/filtro.png'),
                ),
              ),
            ]),
          );
        });
  }
}
