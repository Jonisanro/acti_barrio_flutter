import 'package:acti_barrio_flutter/src/models/markers_response.dart';
import 'package:acti_barrio_flutter/src/provider/markers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageEventosTipo extends StatelessWidget {
  final String tipo;
  const PageEventosTipo({
    Key? key,
    required this.tipo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
      ),
      body: ListEvents(
        tipo: tipo,
      ),
    );
  }
}

class ListEvents extends StatelessWidget {
  final String tipo;
  const ListEvents({
    Key? key,
    required this.tipo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final MarkersProviders markersProviders =
        Provider.of<MarkersProviders>(context);
    return FutureBuilder<List<Evento>>(
        future: markersProviders.getEventForTypes(tipo),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Evento> listEvents = snapshot.data!;
            return ListView.builder(
              itemCount: listEvents.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  child: Card(
                    elevation: 10.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image(
                                width: 50.0,
                                height: 50.0,
                                image:
                                    Image.asset('images/actibarrio_deporte.png')
                                        .image),
                            title: SizedBox(
                                width: size.width * 0.8,
                                child: Text(listEvents[index].descripcion)),
                            subtitle: Text(listEvents[index].direccion),
                            trailing: const Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(
                                  context, '/eventDescriptor',
                                  arguments: listEvents[index]);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
