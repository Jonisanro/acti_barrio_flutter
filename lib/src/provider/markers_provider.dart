import 'dart:async';
import 'package:acti_barrio_flutter/models/markers_response.dart';
import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/custom_image_markers.dart';

class MarkersProviders extends ChangeNotifier {
  late MarkerP tappedMarker;
  List<MarkerP> markers = [];
  MarkersProviders() {
    getDisplayMarkers();
  }

  final StreamController<Map<String, Marker>> _markersStreamController =
      StreamController.broadcast();

  Stream<Map<String, Marker>> get markersStream =>
      _markersStreamController.stream;

  //*Carga marcadores desde el json/http
  getDisplayMarkers() async {
    String data = await rootBundle.loadString('dataJson/app_ab_ubicacion.json');
    final jsonResult = MarkersResponse.fromJson(data);
    markers = jsonResult.results;
    notifyListeners();
  }

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  CustomInfoWindowController get customInfoWindowController =>
      _customInfoWindowController;

  set customInfoWindowController(CustomInfoWindowController value) {
    _customInfoWindowController = value;
    notifyListeners();
  }

  //*Mapa de marcadores
  Map<String, Marker> _markersMap = {};

  Map<String, Marker> get markersMap => _markersMap;

  set markersMap(Map<String, Marker> value) {
    _markersMap = value;

    notifyListeners();
  }

  //*Mapa de filtros activos/inactivos
  Map<String, bool> _filtrosEstado = {
    'deporte': true,
    'arte': true,
    'cursos': true,
    'sociales': true,
    'bici': true,
    'mercado': true,
    'otros': true,
  };

  Map<String, bool> get filtrosEstado => _filtrosEstado;

  set filtrosEstado(Map<String, bool> value) {
    _filtrosEstado = value;

    notifyListeners();
  }

  //*Agregado de marcadores por filtro

  addMarkers(String filtro) async {
    for (var e in markers) {
      if (e.tipo == filtro) {
        BitmapDescriptor bitmap =
            await getAssetImageMarker('images/actibarrio_$filtro.png');

        final markerId = MarkerId(e.id.oid.toString());
        Marker tempMarker = Marker(
          markerId: markerId,
          onTap: () {
            _onMarkerTapped(markerId, markers);
            _customInfoWindowController.addInfoWindow!(
                _CustomInfoWindow(tappedMarker: tappedMarker, e: e),
                LatLng(e.latitud, e.longitud));
          },
          position: LatLng(e.latitud.toDouble(), e.longitud.toDouble()),
          icon: bitmap,
        );

        markersMap.addAll({
          (e.id.oid + e.tipo).toString(): tempMarker,
        });
      }
    }

    _markersStreamController.add(markersMap);
  }
  //*Eliminacion de marcadores por filtro

  removeMarkers(String filtro) async {
    final tempMarkersMap = markersMap;
    tempMarkersMap.removeWhere((key, value) => key.contains(filtro));

    _markersStreamController.add(tempMarkersMap);
  }

  //*Carga de Marcadores
  getMarkers() async {
    BitmapDescriptor bitmap =
        await getAssetImageMarker('images/actibarrio_otros.png');

    for (var e in markers) {
      BitmapDescriptor bitmap =
          await getAssetImageMarker('images/actibarrio_${e.tipo}.png');

      final markerId = MarkerId(e.id.oid.toString());
      Marker tempMarker = Marker(
        markerId: markerId,
        onTap: () {
          _onMarkerTapped(markerId, markers);
          _customInfoWindowController.addInfoWindow!(
              _CustomInfoWindow(tappedMarker: tappedMarker, e: e),
              LatLng(e.latitud, e.longitud));
        },
        position: LatLng(e.latitud.toDouble(), e.longitud.toDouble()),
        icon: bitmap,
      );

      markersMap.addAll({
        (e.id.oid + e.tipo).toString(): tempMarker,
      });
    }

    _markersStreamController.add(markersMap);

    return markersMap;
  }

  //*Toma de datos de marcador seleccionado
  void _onMarkerTapped(
    MarkerId markerId,
    List<MarkerP> markers,
  ) {
    tappedMarker = markers
        .firstWhere((marker) => marker.id.oid.toString() == markerId.value);
  }
}

//*Clase construccion de CustomInfoWindow
class _CustomInfoWindow extends StatelessWidget {
  const _CustomInfoWindow({
    Key? key,
    required this.tappedMarker,
    required this.e,
  }) : super(key: key);

  final MarkerP tappedMarker;
  final MarkerP e;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromRGBO(22, 117, 232, 1)),
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/eventDescriptor',
                  arguments: tappedMarker);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(e.descripcion,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(22, 117, 232, 1))),
                const SizedBox(height: 2),
                Text(e.direccion,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10, color: Colors.black)),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Triangle.isosceles(
            edge: Edge.BOTTOM,
            child: Container(
              color: Colors.blue,
              width: 20.0,
              height: 10.0,
            ),
          ),
        )
      ],
    );
  }
}
