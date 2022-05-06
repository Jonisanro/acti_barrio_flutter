import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

import '../provider/barrios_info.dart';

class ShowDialogBarrios {
  final Map tempListBarrios = {
    'Valentina Norte': {'lat': -38.928105, 'long': -68.167479},
    'Naciones Unidas': {'lat': -38.947740, 'long': -68.032358},
  };

  alerta(BuildContext context) {
    final barriosInfo = Provider.of<BarriosInfo>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          title: const Text('Barrios', style: TextStyle(fontSize: 20)),
          content: SizedBox(
            width: size.width * 0.8,
            height: size.height * 0.35,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Expanded(
                  child: ListView(
                      children: tempListBarrios.keys.map((e) {
                return ListTile(
                  onTap: () {
                    final LatLng barrio = LatLng(
                        tempListBarrios[e]["lat"], tempListBarrios[e]["long"]);
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
                  title: Text(e),
                );
              }).toList()))
            ]),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Donde estoy ahora'),
              onPressed: () async {
                final position =
                    await GeolocatorPlatform.instance.getCurrentPosition();

                barriosInfo.mapboxController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 16.0,
                    ),
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
