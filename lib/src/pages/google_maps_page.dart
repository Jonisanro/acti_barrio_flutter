import 'dart:ui';
import 'package:animate_do/animate_do.dart';

import '../helpers/global_functions.dart';
import '../models/markers_response.dart';
import 'package:acti_barrio_flutter/src/provider/markers_provider.dart';
import 'package:acti_barrio_flutter/src/widgets/show_dialog_filtros.dart';
import 'package:acti_barrio_flutter/src/widgets/show_dialog_barrios.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/mapbox_info.dart';
import 'no_data_page.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late LatLng centerCordenadasDefault = const LatLng(-38.951930, -68.059242);

  late Evento tappedMarker;
  final markers = MarkersProviders();
  @override
  void initState() {
    final markersProviders =
        Provider.of<MarkersProviders>(context, listen: false);

    determinePermissionPosition(context).then((value) async => {
          await markersProviders.getMarkers(
            context,
          ),
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final markersProviders =
        Provider.of<MarkersProviders>(context, listen: false);
    return SafeArea(
      key: _key,
      child: Scaffold(
        drawer: _drawer(),
        body: StreamBuilder(
            stream: markersProviders.markersStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Image(image: AssetImage('images/map_loading.gif')),
                );
              } else {
                if (snapshot.hasData && markersProviders.primeraCarga == true) {
                  return Stack(children: [
                    _mapView(context),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 12.0, right: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  ShowDialogBarrios().alerta(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.grey[200],
                                    backgroundBlendMode: BlendMode.saturation,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 0.3), //(x,y)
                                        blurRadius: 1.0,
                                      ),
                                    ],
                                  ),
                                  child: const Image(
                                    image: AssetImage(
                                        'images/actibarrio_barrios.png'),
                                    height: 65,
                                    width: 65,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          height: 60.0,
                          width: 60.0,
                          child: FloatingActionButton(
                            elevation: 10.0,
                            backgroundColor: Colors.white,
                            onPressed: () async {
                              determinePermissionPosition(context)
                                  .then((value) => {
                                        if (value == true)
                                          {
                                            getCurrentLocation(context),
                                          }
                                      });
                            },
                            child: const Icon(
                              Icons.my_location,
                              color: Colors.black54,
                              size: 25.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0),
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
                        height: 55.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.menu,
                            size: 35.0,
                            color: Colors.grey[600],
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            ShowDialogFiltros().alerta(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.grey[200],
                              backgroundBlendMode: BlendMode.saturation,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 0.3), //(x,y)
                                  blurRadius: 1.0,
                                ),
                              ],
                            ),
                            child: const Image(
                              image: AssetImage('images/filtro.png'),
                              height: 65,
                              width: 65,
                            ),
                          ),
                        ),
                      ),
                    ),
                    (() {
                      if (markersProviders.conection == false) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/noDataPage');
                          },
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 10.0),
                              child: Pulse(
                                infinite: true,
                                duration: const Duration(seconds: 2),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 2.0,
                                          offset: Offset(0.0, 2.0),
                                        ),
                                      ]),
                                  child: Image(
                                    color: Colors.white.withOpacity(0.8),
                                    colorBlendMode: BlendMode.modulate,
                                    image:
                                        const AssetImage('images/no_wifi.png'),
                                    width: size.width * 0.065,
                                    height: size.height * 0.065,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    })(),
                  ]);
                } else {
                  return const NoDataPage();
                }
              }
            }),
      ),
    );
  }

  //*Construccion de la vista del mapa
  Widget _mapView(BuildContext context) {
    final markersProvider =
        Provider.of<MarkersProviders>(context, listen: true);
    final barriosInfo = Provider.of<BarriosInfo>(context, listen: true);

    final markers = markersProvider.markersMap.values.toList();

    return Stack(
      children: [
        GoogleMap(
            mapToolbarEnabled: false,
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
              target: centerCordenadasDefault,
              zoom: 14.0,
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

  //*Drawer Personalizado
  Widget _drawer() {
    final size = MediaQuery.of(context).size;
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
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          child: Drawer(
              child: ListView(
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: Text(
                  'Bienvenido a ActiBarrio, este aplicativo te permite saber y conocer lugares, actividades y eventos que se realizan en tu zona.\nDebes seleccionar tu lugar y filtrar tipo de actividad que estas buscando.\nConócela!!',
                  style: TextStyle(
                      color: Colors.grey[800], height: 1.35, fontSize: 15.0),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ListTile(
                minLeadingWidth: 25.0,
                leading: Icon(
                  LineAwesomeIcons.question_circle,
                  color: Colors.grey[600],
                  size: 30.0,
                ),
                title: Text(
                  "Guia de uso",
                  style: TextStyle(
                    fontSize: 15.0,
                    height: 1.35,
                    color: Colors.grey[800],
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              ListTile(
                minLeadingWidth: 25.0,
                onTap: () => Navigator.pushNamed(context, '/favorite'),
                leading: Icon(
                  LineAwesomeIcons.heart,
                  color: Colors.grey[600],
                  size: 30.0,
                ),
                title: Text(
                  "Favoritos",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15.0,
                    height: 1.35,
                  ),
                ),
              ),
              /* ListTile(
                  minLeadingWidth: 25.0,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageEventosTipo(
                          tipo: mark.tipo,
                        ),
                      )),
                  leading: Icon(
                    LineAwesomeIcons.shoe_prints,
                    color: Colors.grey[600],
                    size: 30.0,
                  ),
                  title: Text(
                    "Eventos",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 15.0,
                      height: 1.35,
                    ),
                  ),
                ), */
              ListTile(
                minLeadingWidth: 25.0,
                leading: Icon(
                  LineAwesomeIcons.share,
                  color: Colors.grey[600],
                  size: 30.0,
                ),
                title: Text(
                  "Comparte Aplicacion",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15.0,
                    height: 1.35,
                  ),
                ),
                onTap: () {
                  //TODO: Ver si va quedar el compartir app
                },
              ),
              ListTile(
                minLeadingWidth: 25.0,
                onTap: () {
                  Navigator.pushNamed(context, '/sugerencia');
                },
                leading: Icon(
                  LineAwesomeIcons.comment,
                  color: Colors.grey[600],
                  size: 30.0,
                ),
                title: Text(
                  "Dejá tu sugerencia",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15.0,
                    height: 1.35,
                  ),
                ),
              ),
              ListTile(
                  minLeadingWidth: 25.0,
                  leading: Icon(
                    LineAwesomeIcons.info,
                    color: Colors.grey[600],
                    size: 30.0,
                  ),
                  title: Text(
                    "Acerca Nuestro",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 15.0,
                      height: 1.35,
                    ),
                  ),
                  onTap: () => Navigator.pushNamed(context, '/acercaDe')),
              SizedBox(
                height: size.height * 0.08,
              ),
              Stack(children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, right: 15.0),
                    child: Text(
                      'Version : 1.0.0',
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 15.0,
                          height: 1.35,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
            ],
          )),
        ),
      ),
    );
  }
}
