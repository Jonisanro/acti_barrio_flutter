import 'package:acti_barrio_flutter/src/models/markers_response.dart';
import 'package:acti_barrio_flutter/src/provider/markers_provider.dart';
import 'package:animate_do/animate_do.dart';
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
  }) : super(key: key);

  @override
  State<ListEvents> createState() => _ListEventsState();
}

class _ListEventsState extends State<ListEvents> {
  late AnimationController animateController;
  List<bool> animationOn = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final markers = Provider.of<MarkersProviders>(context);

    return FutureBuilder<List<Evento>>(
        future: markers.getEventFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final List<Evento> listEvents = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Deslize para eliminar',
                      style: TextStyle(
                          fontSize: 17,
                          height: 1.3,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: listEvents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) async {
                            await setFavorite(context,
                                listEvents[index].id.toString(), false);
                          },
                          background: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                            ),
                            width: double.infinity,
                            height: double.infinity,
                            child: BounceInDown(
                              from: 50.0,
                              child: const Center(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                    size: 35.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  leading: Image(
                                    width: size.width * 0.12,
                                    height: size.height * 0.12,
                                    image: NetworkImage(markers.filters
                                        .where((element) =>
                                            element.nombre ==
                                            listEvents[index].tipo)
                                        .first
                                        .imagen),
                                  ),
                                  title: SizedBox(
                                      width: size.width * 0.8,
                                      child: Text(listEvents[index].nombre)),
                                  subtitle: Text(listEvents[index].direccion +
                                      ' ' +
                                      listEvents[index].altura.toString()),
                                  trailing: const Icon(
                                      Icons.arrow_forward_ios_outlined),
                                  onTap: () async {
                                    Navigator.pushReplacementNamed(
                                            context, '/eventDescriptor',
                                            arguments: listEvents[index])
                                        .then((_) => {setState(() {})});
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No hay eventos'));
          }
        });
  }
}
