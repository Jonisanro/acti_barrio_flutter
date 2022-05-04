import 'package:acti_barrio_flutter/models/markers_response.dart';

import 'package:acti_barrio_flutter/src/provider/markers_provider.dart';
import 'package:acti_barrio_flutter/src/widgets/custom_navigator.dart';
import 'package:acti_barrio_flutter/src/widgets/show_dialog_barrios.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';

import 'package:provider/provider.dart';

import '../provider/barrios_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatLng centerCordenadas = const LatLng(-38.952040, -68.059179);
  bool permissionEnabled = false;

  List<Marker> markersList = [];
  late MarkerP tappedMarker;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _determinePosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final barriosInfo = Provider.of<BarriosInfo>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () async => {
              if (permissionEnabled)
                {
                  await barriosInfo.setPosition(
                    context,
                    CameraPosition(
                      bearing: 0,
                      tilt: 0,
                      target: centerCordenadas,
                      zoom: 16.0,
                    ),
                  )
                }
              else
                {
                  await _determinePosition().then((value) => {
                        barriosInfo.setPosition(
                          context,
                          CameraPosition(
                            bearing: 0,
                            tilt: 0,
                            target: centerCordenadas,
                            zoom: 16.0,
                          ),
                        )
                      })
                }
            },
            child: const Icon(
              Icons.my_location,
              color: Colors.black54,
            ),
          ),
        ),
        body: FutureBuilder<Position>(
          future: _determinePosition(),
          builder: ((context, snapshot) {
            //TODO Revisar que este habilitado el gps , que  los permisos hayan sido consedidos
            if (snapshot.hasData) {
              return Stack(children: [
                _mapView(context),
                const Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomBottonBar()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        ShowDialogBarrios().alerta(context);
                      },
                      child: const Image(
                        image: AssetImage('images/actibarrio_barrios.png'),
                        height: 50.0,
                        width: 50.0,
                      ),
                    ),
                  ),
                )
              ]);
            } else {
              if (snapshot.hasError) {
                return Stack(children: [
                  _mapView(context),
                  const Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomBottonBar()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          ShowDialogBarrios().alerta(context);
                        },
                        child: const Image(
                          image: AssetImage('images/actibarrio_barrios.png'),
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                    ),
                  )
                ]);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          }),
        ),
      ),
    );
  }

  Widget _mapView(BuildContext context) {
    final markersProvider =
        Provider.of<MarkersProviders>(context, listen: true);
    final barriosInfo = Provider.of<BarriosInfo>(context, listen: true);

    return Stack(
      children: [
        GoogleMap(
          onTap: (position) {
            markersProvider.customInfoWindowController.hideInfoWindow!();
          },
          onCameraMove: (position) => {
            markersProvider.customInfoWindowController.onCameraMove!(),
          },
          myLocationEnabled: true,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            barriosInfo.onInitMap(controller);
            markersProvider.customInfoWindowController.googleMapController =
                controller;
          },
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          compassEnabled: false,
          initialCameraPosition: CameraPosition(
            target: centerCordenadas,
            zoom: 16.0,
          ),
          markers: markersProvider.markersMap.values.toSet(),
        ),
        CustomInfoWindow(
          controller: markersProvider.customInfoWindowController,
          height: 70,
          width: 250,
          offset: 30,
        ),
      ],
    );
  }

  Future<Position> _determinePosition() async {
    final markersProviders =
        Provider.of<MarkersProviders>(context, listen: false);
    bool serviceEnabled = false;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return Future.error('Permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    Geolocator.getCurrentPosition().then((value) => {
          centerCordenadas = LatLng(value.latitude, value.longitude),
        });
    await markersProviders.getMarkers();
    return Geolocator.getCurrentPosition();
  }
}
