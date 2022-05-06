import 'dart:ui';

import 'package:acti_barrio_flutter/models/markers_response.dart';

import 'package:acti_barrio_flutter/src/provider/markers_provider.dart';
import 'package:acti_barrio_flutter/src/widgets/custom_navigator.dart';
import 'package:acti_barrio_flutter/src/widgets/show_dialog_barrios.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:provider/provider.dart';

import '../provider/barrios_info.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
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
    _determinePermissionPosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final barriosInfo = Provider.of<BarriosInfo>(context, listen: false);
    return SafeArea(
      key: _key,
      child: Scaffold(
        drawer: _drawer(),
        body: FutureBuilder<Position>(
          future: _determinePermissionPosition(),
          builder: ((context, snapshot) {
            //TODO Revisar que este habilitado el gps , que  los permisos hayan sido consedidos
            if (snapshot.hasData) {
              return Stack(children: [
                _mapView(context),
                const Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomBottonBar(),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            ShowDialogBarrios().alerta(context);
                          },
                          child: const Image(
                            image: AssetImage('images/actibarrio_barrios.png'),
                            height: 55.0,
                            width: 55.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: FloatingActionButton(
                            elevation: 10.0,
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
                                  await _determinePermissionPosition()
                                      .then((value) => {
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
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Colors.white,
                    ),
                    width: 50.0,
                    height: 45.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        size: 30.0,
                        color: Colors.grey[600],
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ),
              ]);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
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

    final markers = markersProvider.markersMap.values.toList();

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
            markers: markers.toSet()),
        CustomInfoWindow(
          controller: markersProvider.customInfoWindowController,
          height: 70,
          width: 250,
          offset: 30,
        ),
      ],
    );
  }

  Future<Position> _determinePermissionPosition() async {
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

  Widget _drawer() {
    final _screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: _screenSize.width * 0.7,
      height: 0.95 * _screenSize.height,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
          child: Drawer(
            child: ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(
                        width: double.infinity,
                        height: 100.0,
                        child: Image(
                          image: AssetImage('images/logo.png'),
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text('ActiBarrio', style: TextStyle(fontSize: 20.0)),
                    const Text(
                        'Deserunt ipsum Lorem elit Lorem incididunt eu. Velit aliqua velit laboris proident. Eiusmod adipisicing ex exercitation fugiat quis labore enim incididunt aute commodo. Do magna irure tempor cupidatat commodo labore. Deserunt laborum ex ut ullamco eiusmod ad cillum irure. Velit laborum Lorem irure cupidatat.',
                        style: TextStyle(),
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ListTile(
                      leading: Icon(
                        LineAwesomeIcons.question_circle,
                        color: Colors.grey[600],
                      ),
                      title: const Text(
                        "Guia de uso",
                      ),
                      onTap: () {
                        /* Navigator.pushReplacementNamed(context, '/home'); */
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        LineAwesomeIcons.share,
                        color: Colors.grey[600],
                      ),
                      title: const Text(
                        "Comparte Aplicacion",
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        LineAwesomeIcons.comment,
                        color: Colors.grey[600],
                      ),
                      title: const Text(
                        "Dejá tu sugerencia",
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        LineAwesomeIcons.info,
                        color: Colors.grey[600],
                      ),
                      title: const Text(
                        "Acerca Nuestro",
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
                const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Version : 1.0.0',
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
