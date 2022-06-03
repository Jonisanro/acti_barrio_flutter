import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/global_functions.dart';
import '../models/markers_response.dart';
import '../provider/mapbox_info.dart';
import '../share_preferences/preferences.dart';

class EventDescriptor extends StatelessWidget {
  const EventDescriptor({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final Evento mark = ModalRoute.of(context)!.settings.arguments as Evento;
    //TODO Cambiar cosas hardcodeadas
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
  Widget build(BuildContext context) {
    if (mark.tipo.length < 6) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(22, 117, 232, 1),
                borderRadius: BorderRadius.circular(8)),
            child: const Center(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: InkWell(
                /* onTap: () {
                    const LatLng barrio = LatLng(-38.947740, -68.032358);
                    barriosInfo.mapboxController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        const CameraPosition(
                          bearing: 0,
                          tilt: 0,
                          target: barrio,
                          zoom: 16.0,
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  }, */
                //TODO:Seleccionar barrio del markador
                child: Text(
                  'Neuquen',
                  style: TextStyle(
                      color: Color.fromARGB(255, 216, 214, 214),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(22, 117, 232, 1),
                borderRadius: BorderRadius.circular(8)),
            child: const Center(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: InkWell(
                /* onTap: () {
                    const LatLng barrio = LatLng(-38.947740, -68.032358);
                    barriosInfo.mapboxController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        const CameraPosition(
                          bearing: 0,
                          tilt: 0,
                          target: barrio,
                          zoom: 16.0,
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  }, */
                //TODO:Seleccionar barrio del markador
                child: Text(
                  'Naciones Unidas',
                  style: TextStyle(
                      color: Color.fromARGB(255, 216, 214, 214),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
          ),
          InkWell(
            /* onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageEventosTipo(
                  tipo: mark.tipo,
                ),
              )), */

            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(22, 117, 232, 1),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: Text(
                  mark.tipo,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 216, 214, 214),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              )),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(22, 117, 232, 1),
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                    child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  child: InkWell(
                    /* onTap: () {
                    const LatLng barrio = LatLng(-38.947740, -68.032358);
                    barriosInfo.mapboxController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        const CameraPosition(
                          bearing: 0,
                          tilt: 0,
                          target: barrio,
                          zoom: 16.0,
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  }, */
                    //TODO:Seleccionar barrio del markador
                    child: Text(
                      'Neuquen',
                      style: TextStyle(
                          color: Color.fromARGB(255, 216, 214, 214),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(22, 117, 232, 1),
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                    child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  child: InkWell(
                    /* onTap: () {
                    const LatLng barrio = LatLng(-38.947740, -68.032358);
                    barriosInfo.mapboxController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        const CameraPosition(
                          bearing: 0,
                          tilt: 0,
                          target: barrio,
                          zoom: 16.0,
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  }, */
                    //TODO:Seleccionar barrio del markador
                    child: Text(
                      'Naciones Unidas',
                      style: TextStyle(
                          color: Color.fromARGB(255, 216, 214, 214),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          InkWell(
            /* onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageEventosTipo(
                  tipo: mark.tipo,
                ),
              )), */

            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(22, 117, 232, 1),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: Text(
                  mark.tipo,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 216, 214, 214),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              )),
            ),
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
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.35,
      child: Image(
        color: Colors.black.withOpacity(0.12),
        colorBlendMode: BlendMode.darken,
        image: AssetImage('images/portada_${mark.tipo}.png'),
        fit: BoxFit.cover,
      ),
    );
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
    bool disable = prefs.existId(widget.mark.id.oid);
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //*Titulo
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.75,
              child: Text(
                widget.mark.descripcion,
                style: const TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {
                disable = !disable;
                setFavorite(context, widget.mark.id.oid, disable);
                setState(() {});
              },
              icon: Icon(
                disable ? Icons.favorite : Icons.favorite_border,
                size: disable ? 30.0 : 25.0,
                color: disable ? Colors.red : Colors.grey,
              ),
            )
          ],
        ),

        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            '(34 cupos restantes)',
            style: TextStyle(fontSize: 12.0, color: Colors.black38),
          ),
        ),
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
    final barriosInfo = Provider.of<BarriosInfo>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //*Fecha
          Row(
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
                children: const [
                  Text(
                    'Desde / Hasta',
                    style: TextStyle(fontSize: 13.0, color: Colors.black38),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text('Miercoles, 12 Jun - Sabado, 13 Jun',
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.bold))
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

              //TODO: Cargar desde el json horarios, fechas y datos de contacto
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Dias / Horas',
                    style: TextStyle(fontSize: 13.0, color: Colors.black38),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text('Lunes 13:00hs - 14:00 hs',
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.bold)),
                  Text('Miercoles 13:00hs - 14:00 hs',
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.bold)),
                  Text('Viernes 13:00hs - 14:00 hs',
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.bold))
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                    children: const [
                      Text(
                        'Referente',
                        style: TextStyle(fontSize: 13.0, color: Colors.black38),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text('San Roman Jonathan',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    //TODO: Armar funcionabilidad para envio de email
                    onPressed: () async {
                      final Uri _emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'smith@example.com',
                          queryParameters: {
                            'subject': 'Example Subject & Symbols are allowed!'
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

          //*Ubicacion
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    children: const [
                      Text(
                        'Ubicación',
                        style: TextStyle(fontSize: 13.0, color: Colors.black38),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text('San Roman Jonathan',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: IconButton(
                  //TODO: Armar funcionabilidad para envio de email
                  onPressed: () async {
                    determinePermissionPosition(context).then((value) => {
                          if (value == true)
                            {
                              getCurrentLocation(context),
                            }
                        });
                  },
                  icon: const Icon(
                    Icons.location_on,
                    size: 30.0,
                    color: Color.fromRGBO(22, 117, 232, 1),
                  ),
                ),
              ),
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
        Text(mark.descripcion,
            style:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10.0,
        ),
        const Text(
            'Mollit velit sint velit labore voluptate et laboris eu excepteur sit exercitation ad. Ut cillum ea dolore occaecat elit sunt Lorem ut in excepteur. Est aute enim adipisicing duis quis. Laboris tempor fugiat nisi voluptate exercitation. Fugiat sit aliquip officia cillum proident ex. Velit esse cillum esse sunt et minim labore velit dolor ullamco fugiat commodo nulla. Nulla nulla duis et laboris nisi nisi ex do nulla mollit sint cillum amet.'),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
