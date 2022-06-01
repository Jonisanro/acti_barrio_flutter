import 'package:acti_barrio_flutter/src/models/markers_response.dart';
import 'package:acti_barrio_flutter/src/provider/markers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/global_functions.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool disable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: const ListEvents(),
    );
  }
}

class ListEvents extends StatefulWidget {
  const ListEvents({
    Key? key,
    this.disable = true,
  }) : super(key: key);

  final bool disable;

  @override
  State<ListEvents> createState() => _ListEventsState();
}

class _ListEventsState extends State<ListEvents> {
  List<bool> animationOn = [];
  @override
  Widget build(BuildContext context) {
    bool disable = true;
    final size = MediaQuery.of(context).size;
    final markers = Provider.of<MarkersProviders>(context);
    return FutureBuilder<List<Evento>>(
        future: markers.getEventFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Evento> listEvents = snapshot.data!;

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size.width * 0.95,
                  child: ListView.builder(
                    itemCount: listEvents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Card(
                          elevation: 5.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Image(
                                      width: 45.0,
                                      height: 45.0,
                                      image: Image.asset(
                                              'images/actibarrio_deporte.png')
                                          .image),
                                  title: SizedBox(
                                      width: size.width * 0.8,
                                      child:
                                          Text(listEvents[index].descripcion)),
                                  subtitle: Text(listEvents[index].direccion),
                                  trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        setFavorite(context,
                                            listEvents[index].id.oid, !disable);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      size: 30.0,
                                      color: Colors.red,
                                    ),
                                  ),
                                  onTap: () async {
                                    Navigator.pushNamed(
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
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('No hay eventos'));
          }
        });
  }
}
