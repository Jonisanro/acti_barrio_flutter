import 'package:acti_barrio_flutter/src/provider/markers_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

import '../provider/mapbox_info.dart';

class ShowDialogBarrios {
  alerta(BuildContext context) {
    final markersProvider =
        Provider.of<MarkersProviders>(context, listen: false);
    final barriosInfo = Provider.of<BarriosInfo>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SizedBox(
            width: size.width * 0.85,
            height: size.height * 0.7,
            child: Stack(children: [
              AlertDialog(
                actionsAlignment: MainAxisAlignment.end,
                actionsOverflowAlignment: OverflowBarAlignment.end,
                actionsOverflowButtonSpacing: 0.0,
                insetPadding: const EdgeInsets.all(0.0),
                actionsPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                content: SizedBox(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Column(children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Scrollbar(
                        child: ListView(
                            padding: const EdgeInsets.all(0.0),
                            shrinkWrap: false,
                            children: markersProvider.locations.map((e) {
                              return e.barriosLista.isNotEmpty
                                  ? ExpansionTile(
                                      iconColor: Colors.blueAccent,
                                      collapsedIconColor: Colors.black,
                                      subtitle: const Text(
                                        'Barrios',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      title: Text(
                                        e.nombre,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      children: e.barriosLista
                                          .map((b) => ListTile(
                                                title: Text(
                                                  b.nombre,
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    height: 1.3,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                onTap: () {
                                                  final LatLng barrio = LatLng(
                                                      b.latitud, b.longitud);
                                                  barriosInfo.mapboxController
                                                      .animateCamera(
                                                    CameraUpdate
                                                        .newCameraPosition(
                                                      CameraPosition(
                                                        bearing: 0,
                                                        tilt: 0,
                                                        target: barrio,
                                                        zoom: 16.0,
                                                      ),
                                                    ),
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                              ))
                                          .toList(),
                                    )
                                  : ListTile(
                                      onTap: () {
                                        final LatLng barrio = LatLng(
                                            markersProvider.locations
                                                .firstWhere((element) =>
                                                    e.nombre == element.nombre)
                                                .latitud,
                                            markersProvider.locations
                                                .firstWhere((element) =>
                                                    e.nombre == element.nombre)
                                                .longitud);
                                        barriosInfo.mapboxController
                                            .animateCamera(
                                          CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                              bearing: 0,
                                              tilt: 0,
                                              target: barrio,
                                              zoom: 16.0,
                                            ),
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      title: Text(
                                        e.nombre,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3,
                                        ),
                                      ),
                                    );
                            }).toList()),
                      ),
                    ))
                  ]),
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
              ),
              const Align(
                alignment: AlignmentDirectional(0.0, -1.38),
                child: Image(
                  width: 100.0,
                  height: 100.0,
                  image: AssetImage('images/actibarrio_barrios.png'),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
