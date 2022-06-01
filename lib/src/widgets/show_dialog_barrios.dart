import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

import '../helpers/global_functions.dart';
import '../provider/mapbox_info.dart';

class ShowDialogBarrios {
  final Map tempListBarrios = {
    'Valentina Norte': {'lat': -38.928105, 'long': -68.167479},
    'Naciones Unidas': {'lat': -38.947740, 'long': -68.032358},
    'Naciones Unidas2': {'lat': -38.947740, 'long': -68.032358},
    'Naciones Unidas3': {'lat': -38.947740, 'long': -68.032358},
    'Naciones Unidas4': {'lat': -38.947740, 'long': -68.032358},
    'Naciones Unidas5': {'lat': -38.947740, 'long': -68.032358},
    'Naciones Unidas6': {'lat': -38.947740, 'long': -68.032358},
  };

  alerta(BuildContext context) {
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
                            children: tempListBarrios.keys.map((e) {
                              return ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                onTap: () {
                                  final LatLng barrio = LatLng(
                                      tempListBarrios[e]["lat"],
                                      tempListBarrios[e]["long"]);
                                  barriosInfo.mapboxController.animateCamera(
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
                                  e,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      height: 1.3),
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
                      'Donde estoy ahora',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                          fontSize: 18.0,
                          height: 1.3),
                    ),
                    onPressed: () async {
                      determinePermissionPosition(context).then((value) => {
                            if (value == true)
                              {
                                getCurrentLocation(context),
                              }
                          });
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  CupertinoDialogAction(
                    child: const Text(
                      'Cancelar',
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
