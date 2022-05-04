import 'package:acti_barrio_flutter/models/markers_response.dart';
import 'package:flutter/material.dart';

//TODO:Manejar estado de favoritos
bool disable = false;

class EventDescriptor extends StatelessWidget {
  const EventDescriptor({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Stack(
          children: const [
            Background(),
            Align(alignment: Alignment.bottomCenter, child: Contenedor()),
          ],
        ));
  }
}

class Contenedor extends StatelessWidget {
  const Contenedor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MarkerP mark = ModalRoute.of(context)!.settings.arguments as MarkerP;
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: ListView(
          children: [
            _Titulo(mark: mark),
            const _Tags(),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(22, 117, 232, 1),
              borderRadius: BorderRadius.circular(8)),
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Deporte',
              style: TextStyle(
                  color: Color.fromARGB(255, 216, 214, 214),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          )),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(22, 117, 232, 1),
              borderRadius: BorderRadius.circular(8)),
          child: const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Naciones Unidas',
              style: TextStyle(
                  color: Color.fromARGB(255, 216, 214, 214),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          )),
        ),
      ],
    );
  }
}

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.35,
      child: const Image(
        image: AssetImage('images/deporte.jpg'),
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

  final MarkerP mark;

  @override
  State<_Titulo> createState() => _TituloState();
}

class _TituloState extends State<_Titulo> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //*Titulo
        SizedBox(
          height: 30.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.75,
                child: Text(
                  widget.mark.descripcion,
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {
                  disable = !disable;
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
  final MarkerP mark;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
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

          //*Referente
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
              const SizedBox(
                width: 40,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.email,
                  size: 25.0,
                  color: Color.fromRGBO(22, 117, 232, 1),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.phone,
                  size: 25.0,
                  color: Color.fromRGBO(22, 117, 232, 1),
                ),
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
          //*Ubicacion
          Row(
            mainAxisSize: MainAxisSize.max,
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
                children: [
                  const Text(
                    'Ubiación',
                    style: TextStyle(fontSize: 13.0, color: Colors.black38),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.35,
                        child: Text(mark.direccion,
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.fade,
                            )),
                      ),
                      const SizedBox(width: 90.0),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.location_on,
                          size: 25.0,
                          color: Color.fromRGBO(22, 117, 232, 1),
                        ),
                      ),
                    ],
                  ),
                ],
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

  final MarkerP mark;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(mark.descripcion,
            style:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10.0,
        ),
        const Text(
            'Mollit velit sint velit labore voluptate et laboris eu excepteur sit exercitation ad. Ut cillum ea dolore occaecat elit sunt Lorem ut in excepteur. Est aute enim adipisicing duis quis. Laboris tempor fugiat nisi voluptate exercitation. Fugiat sit aliquip officia cillum proident ex. Velit esse cillum esse sunt et minim labore velit dolor ullamco fugiat commodo nulla. Nulla nulla duis et laboris nisi nisi ex do nulla mollit sint cillum amet.')
      ],
    );
  }
}
