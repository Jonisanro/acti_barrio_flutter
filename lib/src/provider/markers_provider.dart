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

  //*Carga marcadores desde el json/http
  getDisplayMarkers() async {
    String data = await rootBundle.loadString('dataJson/app_ab_ubicacion.json');
    final jsonResult = MarkersResponse.fromJson(data);
    markers = jsonResult.results;
    notifyListeners();
  }

  //*Controllador del GoogleMaps
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
    'Deporte': true,
    'Arte': true,
    'Cursos': true,
    'Sociales': true,
    'Bici': true,
    'Mercado': true,
    'Otros': true,
  };

  Map<String, bool> get filtrosEstado => _filtrosEstado;

  set filtrosEstado(Map<String, bool> value) {
    _filtrosEstado = value;

    notifyListeners();
  }

  //*Agregado de marcadores por filtro

  addMarkers(String filtro) async {
    markers.forEach((e) async {
      if (e.tipo == filtro) {
        BitmapDescriptor bitmap =
            await getAssetImageMarker('images/actibarrio_otros.png');

        switch (e.tipo) {
          case 'Otros':
            bitmap = await getAssetImageMarker('images/actibarrio_otros.png');
            break;
          case 'Deporte':
            bitmap = await getAssetImageMarker('images/actibarrio_deporte.png');
            break;
          case 'Arte':
            bitmap = await getAssetImageMarker('images/actibarrio_arte.png');

            break;
          case 'Sociales':
            bitmap =
                await getAssetImageMarker('images/actibarrio_sociales.png');

            break;

          case 'Cursos':
            bitmap = await getAssetImageMarker('images/actibarrio_cursos.png');
            break;
          case 'Bici':
            bitmap = await getAssetImageMarker('images/actibarrio_bici.png');
            break;

          case 'Mercado':
            bitmap = await getAssetImageMarker('images/actibarrio_mercado.png');
            break;
          default:
            await getAssetImageMarker('images/actibarrio_otros.png');
        }

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
      notifyListeners();
    });
    Future.delayed(const Duration(milliseconds: 500), () {}).then((_) {
      notifyListeners();
    });
  }
  //*Eliminacion de marcadores por filtro

  removeMarkers(String filtro) async {
    final tempMarkersMap = markersMap;
    tempMarkersMap.removeWhere((key, value) => key.contains(filtro));
    markersMap = tempMarkersMap;
    Future.delayed(const Duration(milliseconds: 500), () {}).then((_) {
      notifyListeners();
    });
  }

  //*Carga de Marcadores
  getMarkers() async {
    BitmapDescriptor bitmap =
        await getAssetImageMarker('images/actibarrio_otros.png');

    for (var e in markers) {
      switch (e.tipo) {
        case 'Otros':
          bitmap = await getAssetImageMarker('images/actibarrio_otros.png');
          break;
        case 'Deporte':
          bitmap = await getAssetImageMarker('images/actibarrio_deporte.png');
          break;
        case 'Arte':
          bitmap = await getAssetImageMarker('images/actibarrio_arte.png');

          break;
        case 'Sociales':
          bitmap = await getAssetImageMarker('images/actibarrio_sociales.png');

          break;

        case 'Cursos':
          bitmap = await getAssetImageMarker('images/actibarrio_cursos.png');
          break;

        case 'Bici':
          bitmap = await getAssetImageMarker('images/actibarrio_bici.png');
          break;

        case 'Mercado':
          bitmap = await getAssetImageMarker('images/actibarrio_mercado.png');
          break;
        default:
      }

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
