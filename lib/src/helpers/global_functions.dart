import 'package:acti_barrio_flutter/src/share_preferences/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/markers_response.dart';
import '../provider/mapbox_info.dart';

//*Obtiene la ubicación actual
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

//*Consulta si esta activado el gps y permisos
Future determinePermissionPosition(BuildContext context) async {
  LocationPermission? permission;

  bool serviceEnabled = false;

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

//*Muestra un dialogo para habilitar el gps
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

//*Muestra un dialogo para habilitar los permisos
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

//*Setea o elimina eventos favoritos
Future<bool> setFavorite(BuildContext context, String id, bool disable) async {
  final prefs = Preferences();
  if (disable) {
    prefs.addFavorite(id);
  } else {
    prefs.removeFavorite(id);
  }

  return true;
}

//*Trae la imagen del filtro desde  sharedPreferences
Future<String> getImageFilter(Filtro filtro) async {
  final prefs = await SharedPreferences.getInstance();
  final _base64 = prefs.getString(filtro.nombre)!;

  return _base64;
}

//*Revisa si se hizo la primera carga y si hay conexion a internet
Future<bool> getPrimeraCarga() async {
  final prefs = await SharedPreferences.getInstance();
  final bool? primeraCarga = prefs.getBool('primeraCarga');
  bool result = await InternetConnectionChecker().hasConnection;

  if (primeraCarga == null || primeraCarga == false) {
    return false;
  }

  if (primeraCarga == true && !result) {
    return true;
  }

  return false;
}
