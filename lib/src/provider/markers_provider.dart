import 'dart:async';

import 'package:acti_barrio_flutter/src/models/markers_response.dart';
import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/custom_image_markers.dart';
import '../share_preferences/preferences.dart';

class MarkersProviders extends ChangeNotifier {
  late Evento tappedMarker;
  List<Evento> markers = [];
  MarkersProviders() {
    getDisplayMarkers();
  }

//*Stream para escuchar cambios en el mapa de marcadores
  final StreamController<Map<String, Marker>> _markersStreamController =
      StreamController.broadcast();

  Stream<Map<String, Marker>> get markersStream =>
      _markersStreamController.stream;

  //*Carga marcadores desde el json/https
  /* getDisplayMarkers() async {
    final url = Uri.parse(
        "http://10.0.2.2:3001/api/modules/actibarrio/traerActividades");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      final jsonResult = MarkersResponse.fromJson(data);
      markers = jsonResult.results;
      notifyListeners();
      return markers;
    }
  } */

  getDisplayMarkers() async {
    String data = await rootBundle.loadString('dataJson/app_ab_ubicacion.json');
    final jsonResult = MarkersResponse.fromJson(data);
    markers = jsonResult.results;
    notifyListeners();
    return markers;
  }

  //*Cargar eventos segun tipo
  Future<List<Evento>> getEventForTypes(String tipo) async {
    List<Evento> markersListTipo = [];
    String data = await rootBundle.loadString('dataJson/app_ab_ubicacion.json');
    final jsonResult = MarkersResponse.fromJson(data);
    markers = jsonResult.results;

    for (var element in markers) {
      if (element.tipo == tipo) {
        markersListTipo.add(element);
      }
    }

    notifyListeners();
    return markersListTipo;
  }

  //*Cargar eventos favoritos
  Future<List<Evento>> getEventFavorites() async {
    final prefs = Preferences();
    List<Evento> markersListTipo = [];
    String data = await rootBundle.loadString('dataJson/app_ab_ubicacion.json');
    final jsonResult = MarkersResponse.fromJson(data);
    markers = jsonResult.results;
    if (prefs.favorites != null) {
      for (var element in prefs.favorites) {
        final temp = markers.where((e) => e.id.oid == element).first;
        markersListTipo.add(temp);
      }
    }

    notifyListeners();
    return markersListTipo;
  }

  //*Ventana de informacion de evento personalizada
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

  //*Mapa de filtros activos/inactivos , cargarlos desde http
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

  addMarkers(BuildContext context, String filtro) async {
    for (var e in markers) {
      if (e.tipo == filtro) {
        BitmapDescriptor bitmap =
            await getAssetImageMarker('images/actibarrio_$filtro.png', context);

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
  getMarkers(BuildContext context) async {
    for (var e in markers) {
      BitmapDescriptor bitmap =
          await getAssetImageMarker('images/actibarrio_${e.tipo}.png', context);

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

    Future.delayed(const Duration(milliseconds: 500), () {
      _markersStreamController.add(markersMap);
    });

    return markersMap;
  }

  //*Toma de datos de marcador seleccionado
  void _onMarkerTapped(
    MarkerId markerId,
    List<Evento> markers,
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

  final Evento tappedMarker;
  final Evento e;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(e.descripcion,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 65, 125, 135))),
                  const SizedBox(height: 1),
                  Text(e.direccion,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 10, color: Colors.black)),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Triangle.isosceles(
            edge: Edge.BOTTOM,
            child: Container(
              color: const Color.fromRGBO(81, 167, 177, 1),
              width: 20.0,
              height: 15.0,
            ),
          ),
        )
      ],
    );
  }
}
