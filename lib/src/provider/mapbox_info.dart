import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BarriosInfo with ChangeNotifier {
  late GoogleMapController _mapController;

  GoogleMapController get mapboxController => _mapController;

  set mapboxController(GoogleMapController value) {
    _mapController = value;

    notifyListeners();
  }

//*MapController iniciacion de mapa
  void onInitMap(GoogleMapController controller) {
    _mapController = controller;
  }

  Future setPosition(BuildContext context, CameraPosition update) async {
    final barriosInfo = Provider.of<BarriosInfo>(context, listen: false);

    await barriosInfo.mapboxController
        .animateCamera(CameraUpdate.newCameraPosition(update));
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
