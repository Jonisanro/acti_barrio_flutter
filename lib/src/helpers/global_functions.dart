import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../share_preferences/preferences.dart';
import '../provider/mapbox_info.dart';
import '../provider/markers_provider.dart';

void getCurrentLocation(BuildContext context) async {
  final barriosInfo = Provider.of<BarriosInfo>(context, listen: false);

  final position = await GeolocatorPlatform.instance.getCurrentPosition();

  barriosInfo.mapboxController.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16.0,
      ),
    ),
  );
}

Future determinePermissionPosition(BuildContext context) async {
  LocationPermission? permission;
  final markersProviders =
      Provider.of<MarkersProviders>(context, listen: false);
  bool serviceEnabled = false;

  await markersProviders.getMarkers();

  //*Revisa si Gps esta habilitado
  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    //*Si esta deshabilitado, pregunta si desea habilitarlo
    await enabledGpsDialog(context);
    return false;
  }
  //*Chequea si los permisos estan concedidos
  permission = await Geolocator.checkPermission();
  //*Si no estan concedidos los pide
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    //*Si no se conceden los permisos no sigue
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.

      return false;
    }
  }
  //*Si se deniegan los permisos para siempre
  if (permission == LocationPermission.deniedForever) {
    await enabledPermissionDialog(context);
    // Permissions are denied forever, handle appropriately.

    return false;
  }

  //*Si se conceden los permisos sigue

  Geolocator.getCurrentPosition().then((value) => {});

  return true;
}

Future<dynamic> enabledGpsDialog(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          title: const Text('GPS desactivado', style: TextStyle(fontSize: 20)),
          content: const Text(
              'Para poder usar la aplicación necesitas activar el GPS'),
          actions: [
            const Divider(
              thickness: 1.0,
            ),
            CupertinoDialogAction(
              child: const Text('Abrir Configuracion'),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings().then((value) => {});
              },
            ),
            const Divider(
              thickness: 1.0,
            ),
            CupertinoDialogAction(
              child: const Text('Cancelar'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

Future<dynamic> enabledPermissionDialog(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          title: const Text('Permisos Desactivados',
              style: TextStyle(fontSize: 20)),
          content: const Text(
              'Para poder usar la aplicación necesitas activar los permisos'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Abrir Configuracion'),
              onPressed: () async {
                Geolocator.openAppSettings();

                Navigator.of(context).pop();
              },
            ),
            const Divider(
              thickness: 1.0,
            ),
            CupertinoDialogAction(
              child: const Text('Cancelar'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

Future<bool> setFavorite(BuildContext context, String id, bool disable) async {
  final prefs = Preferences();
  if (disable) {
    prefs.addFavorite(id);
  } else {
    prefs.removeFavorite(id);
  }

  return true;
}
