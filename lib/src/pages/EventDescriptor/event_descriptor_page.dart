import 'dart:convert';
import 'dart:typed_data';

import 'package:acti_barrio_flutter/src/models/markers_response.dart';
import 'package:acti_barrio_flutter/src/pages/EventDescriptor/widgets/blue_container.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helpers/global_functions.dart';
import '../../models/markers_response.dart';
import '../../provider/mapbox_info.dart';
import '../../share_preferences/preferences.dart';

class EventDescriptor extends StatelessWidget {
  const EventDescriptor({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final Evento mark = ModalRoute.of(context)!.settings.arguments as Evento;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          hoverColor: Colors.transparent,
          hoverElevation: 0.0,
          foregroundColor: Colors.transparent,
          elevation: 0.0,
          disabledElevation: 0.0,
          highlightElevation: 0.0,
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Stack(
          children: [
            Background(
              mark: mark,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Contenedor(
                  mark: mark,
                )),
          ],
        ));
  }
}

class Contenedor extends StatelessWidget {
  const Contenedor({
    Key? key,
    required this.mark,
  }) : super(key: key);
  final Evento mark;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: ListView(
          padding: const EdgeInsets.only(top: 20.0),
          children: [
            _Titulo(mark: mark),
            _Tags(mark: mark),
            const SizedBox(
              height: 10.0,
            ),
            _FechaHoraContacto(mark: mark),
            const SizedBox(
              height: 10.0,
            ),
            const Divider(
              thickness: 1.0,
              color: Colors.grey,
            ),
            _Descripcion(mark: mark),
          ],
        ),
      ),
    );
  }
}

class _Tags extends StatelessWidget {
  const _Tags({
    Key? key,
    required this.mark,
  }) : super(key: key);

  final Evento mark;

  @override
  //*Si los tags no son tan largos se muestran en linea
  Widget build(BuildContext context) {
    if (mark.localidad.nombre.length < 8 &&
        mark.localidad.barrio.nombre.length < 8) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          blueContainer(mark.tipo),
          const SizedBox(
            width: 10.0,
          ),
          blueContainer(mark.localidad.nombre),
          const SizedBox(
            width: 10.0,
          ),
          mark.localidad.barrio.nombre != ''
              ? blueContainer(mark.localidad.barrio.nombre)
              : Container(),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              blueContainer(mark.tipo),
              blueContainer(mark.localidad.nombre),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              mark.localidad.barrio.nombre != ''
                  ? blueContainer(mark.localidad.barrio.nombre)
                  : Container(),
            ],
          ),
        ],
      );
    }
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.mark,
  }) : super(key: key);
  final Evento mark;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getImagePalette(context, mark.tipo),
        builder: (context, AsyncSnapshot<Color> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final color = snapshot.data;

            return SizedBox(
              child: Image(
                color: color!.withOpacity(0.8),
                colorBlendMode: BlendMode.colorBurn,
                image: const AssetImage('images/portada_generica2.png'),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class _Titulo extends StatefulWidget {
  const _Titulo({
    Key? key,
    required this.mark,
  }) : super(key: key);

  final Evento mark;

  @override
  State<_Titulo> createState() => _TituloState();
}

class _TituloState extends State<_Titulo> {
  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    bool disable = prefs.existId(widget.mark.id);
    final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //*Titulo
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.75,
              child: Text(
                widget.mark.nombre,
                style: const TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            disable = !disable;
            setFavorite(context, widget.mark.id, disable);
            setState(() {});
          },
          icon: Icon(
            disable ? Icons.favorite : Icons.favorite_border,
            size: disable ? 30.0 : 25.0,
            color: disable ? Colors.red : Colors.grey,
          ),
        )
      ],
    );
  }
}

class _FechaHoraContacto extends StatelessWidget {
  const _FechaHoraContacto({
    Key? key,
    required this.mark,
  }) : super(key: key);
  final Evento mark;

  @override
  Widget build(BuildContext context) {
    final fechas = mark.fechas.fechas[0];
    final size = MediaQuery.of(context).size;
    final barriosInfo = Provider.of<BarriosInfo>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          //*Fecha
          mark.fechas.tipo == 'temporal'
              ? Row(
                  children: [
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 224, 235, 240)),
                      child: const Icon(
                        Icons.calendar_month_outlined,
                        size: 30.0,
                        color: Color.fromRGBO(22, 117, 232, 1),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Desde / Hasta',
                          style:
                              TextStyle(fontSize: 13.0, color: Colors.black38),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Row(
                          children: [
                            Text(
                              formatDate(
                                  DateTime.parse(mark.fechas.fechaInicio),
                                  [dd, '/', mm, '/', yyyy]),
                              style: const TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Text(
                              '-',
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              formatDate(DateTime.parse(mark.fechas.fechaFin),
                                  [dd, '-', mm, '-', yyyy]),
                              style: const TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                )
              : Container(),

          const SizedBox(
            height: 10.0,
          ),
          const Divider(
            color: Colors.black38,
            thickness: 1.0,
          ),
          const SizedBox(
            height: 10.0,
          ),
          //*Hora y Dia
          Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 224, 235, 240)),
                child: const Icon(
                  Icons.access_time,
                  size: 30.0,
                  color: Color.fromRGBO(22, 117, 232, 1),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              mark.fechas.tipo == 'temporal'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dias / Horas',
                          style:
                              TextStyle(fontSize: 13.0, color: Colors.black38),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              fechas['lunes']['inicio'] != ''
                                  ? Text(
                                      'Lunes: ${fechas['lunes']['inicio']} hs'
                                      ' - '
                                      '${fechas['lunes']['fin']} hs',
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Container(),
                              fechas['martes']['inicio'] != ''
                                  ? Text(
                                      'Martes: ${fechas['martes']['inicio']} hs'
                                      ' - '
                                      '${fechas['martes']['fin']} hs',
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Container(),
                              fechas['miércoles']['inicio'] != ''
                                  ? Text(
                                      'Miércoles: ${fechas['miércoles']['inicio']} hs'
                                      ' - '
                                      '${fechas['miércoles']['fin']} hs',
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Container(),
                              fechas['jueves']['inicio'] != ''
                                  ? Text(
                                      'Jueves: ${fechas['jueves']['inicio']} hs'
                                      ' - '
                                      '${fechas['jueves']['fin']} hs',
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Container(),
                              fechas['viernes']['inicio'] != ''
                                  ? Text(
                                      'Viernes: ${fechas['viernes']['inicio']} hs'
                                      ' - '
                                      '${fechas['viernes']['fin']} hs',
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Container(),
                              fechas['sábado']['inicio'] != ''
                                  ? Text(
                                      'Sábado: ${fechas['sábado']['inicio']} hs'
                                      ' - '
                                      '${fechas['sábado']['fin']} hs',
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Container(),
                              fechas['domingo']['inicio'] != ''
                                  ? Text(
                                      'Domingo: ${fechas['domingo']['inicio']} hs'
                                      ' - '
                                      '${fechas['domingo']['fin']} hs',
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Container(),
                            ])
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dias / Horas',
                          style:
                              TextStyle(fontSize: 13.0, color: Colors.black38),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: mark.fechas.fechas
                              .map((i) => Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: 10.0),
                                      Text(
                                        i + 'hs',
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        )
                      ],
                    ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Divider(
            color: Colors.black38,
            thickness: 1.0,
          ),
          const SizedBox(
            height: 10.0,
          ),

          //*Referente
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 224, 235, 240)),
                    child: const Icon(
                      Icons.person,
                      size: 30.0,
                      color: Color.fromRGBO(22, 117, 232, 1),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Referente',
                        style: TextStyle(fontSize: 13.0, color: Colors.black38),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      Text(mark.contacto.nombreReferente,
                          style: const TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                width: 60.0,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      final Uri _emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: mark.contacto.email,
                          queryParameters: {
                            'subject': mark.nombre,
                            'body':
                                'Hola,&nbsp;me&nbsp;gustaría&nbsp;saber&nbsp;más&nbsp;sobre&nbsp;el&nbsp;evento:&nbsp;${mark.nombre}',
                          });
                      launchUrl(_emailLaunchUri);
                    },
                    icon: const Icon(
                      Icons.email,
                      size: 30.0,
                      color: Color.fromRGBO(22, 117, 232, 1),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      final Uri _phoneLaunchUri = Uri(
                        scheme: 'tel',
                        path: '+5411341234567',
                      );
                      launchUrl(_phoneLaunchUri);
                    },
                    icon: const Icon(
                      Icons.phone,
                      size: 30.0,
                      color: Color.fromRGBO(22, 117, 232, 1),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Divider(
            color: Colors.black38,
            thickness: 1.0,
          ),
          const SizedBox(
            height: 10.0,
          ),

          //*Ubicacion
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 224, 235, 240)),
                    child: const Icon(
                      Icons.person,
                      size: 30.0,
                      color: Color.fromRGBO(22, 117, 232, 1),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ubicación',
                        style: TextStyle(fontSize: 13.0, color: Colors.black38),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      SizedBox(
                        width: size.width * 0.5,
                        child: Text(
                          "${mark.direccion} ${mark.altura}",
                          style: const TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      LatLng barrio = LatLng(mark.latitud, mark.longitud);
                      barriosInfo.mapboxController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            bearing: 0,
                            tilt: 0,
                            target: barrio,
                            zoom: 17.0,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.location_on_rounded,
                      size: 30.0,
                      color: Color.fromRGBO(22, 117, 232, 1),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _Descripcion extends StatelessWidget {
  const _Descripcion({
    Key? key,
    required this.mark,
  }) : super(key: key);

  final Evento mark;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Text(mark.nombre,
            style:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10.0,
        ),
        Text(mark.descripcion),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

// Calculate dominant color from ImageProvider

}

Future<Color> getImagePalette(BuildContext context, String tipo) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final imagen = prefs.getString(tipo);
  final Uint8List bytes = base64Decode(imagen!);

  final PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(
    MemoryImage(bytes),
    size: const Size(200, 200),
    region: const Rect.fromLTRB(0, 0, 100, 100),
    maximumColorCount: 2,
  );
  return paletteGenerator.dominantColor!.color;
}

void setCameraPosition(BuildContext context, Evento mark) {
  final barriosinfo = Provider.of<BarriosInfo>(context, listen: false);
  LatLng barrio = LatLng(mark.latitud, mark.latitud);
  barriosinfo.mapboxController.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        tilt: 0,
        target: barrio,
        zoom: 16.0,
      ),
    ),
  );
  Navigator.pop(context);
}
