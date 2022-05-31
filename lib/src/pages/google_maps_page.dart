import 'dart:ui';
import 'package:acti_barrio_flutter/models/markers_response.dart';
import 'package:acti_barrio_flutter/src/provider/markers_provider.dart';
import 'package:acti_barrio_flutter/src/widgets/custom_navigator.dart';
import 'package:acti_barrio_flutter/src/widgets/show_dialog_barrios.dart';
import 'package:flutter/cupertino.dart';
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
  dynamic ispermissionEnabled = false;
  bool isGpsEnabled = false;
  LocationPermission? permission;
  List<Marker> markersList = [];
  late MarkerP tappedMarker;

  @override
  void initState() {
    final markersProviders =
        Provider.of<MarkersProviders>(context, listen: false);
    markersProviders.getMarkers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final barriosInfo = Provider.of<BarriosInfo>(context, listen: false);
    final markersProviders =
        Provider.of<MarkersProviders>(context, listen: false);
    return SafeArea(
      key: _key,
      child: Scaffold(
        drawer: _drawer(),
        body: StreamBuilder(
          stream: markersProviders.markersStream,
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
                              await _determinePermissionPosition()
                                  .then((value) async => {
                                        isGpsEnabled = await Geolocator
                                            .isLocationServiceEnabled(),
                                        ispermissionEnabled =
                                            await Geolocator.checkPermission(),
                                        if (isGpsEnabled &&
                                            ispermissionEnabled ==
                                                LocationPermission.whileInUse)
                                          await barriosInfo.setPosition(
                                            context,
                                            CameraPosition(
                                              bearing: 0,
                                              tilt: 0,
                                              target: centerCordenadas,
                                              zoom: 16.0,
                                            ),
                                          ),
                                        setState(() {}),
                                      })
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
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

  Future _determinePermissionPosition() async {
    bool serviceEnabled = false;

    //*Revisa si Gps esta habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      //*Si esta deshabilitado, pregunta si desea habilitarlo
      await _enabledGpsDialog();
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
      await _enabledPermissionDialog();
      // Permissions are denied forever, handle appropriately.

      return false;
    }

    //*Si se conceden los permisos sigue

    Geolocator.getCurrentPosition().then((value) => {
          centerCordenadas = LatLng(value.latitude, value.longitude),
        });

    return Geolocator.getCurrentPosition();
  }

  Future<dynamic> _enabledGpsDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
            title:
                const Text('GPS desactivado', style: TextStyle(fontSize: 20)),
            content: const Text(
                'Para poder usar la aplicación necesitas activar el GPS'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Abrir Configuracion'),
                onPressed: () async {
                  await Geolocator.openLocationSettings();
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          );
        });
  }

  Future<dynamic> _enabledPermissionDialog() {
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
            ],
          );
        });
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
