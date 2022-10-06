import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/global_functions.dart';
import '../models/markers_response.dart';
import '../provider/markers_provider.dart';

class CustomButtonColor extends StatefulWidget {
  final Filtro filtro;

  const CustomButtonColor({Key? key, required this.filtro}) : super(key: key);

  @override
  State<CustomButtonColor> createState() => _CustomButtonColorState();
}

class _CustomButtonColorState extends State<CustomButtonColor> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final markersProvider =
        Provider.of<MarkersProviders>(context, listen: false);

    return FutureBuilder<String>(
      future: getImageFilter(widget.filtro),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          final Uint8List bytes = base64Decode(snapshot.data!);
          //TODO:Solucionar el error de la imagen DESACTIVADA
          return InkWell(
              onTap: () async {
                widget.filtro.estado = !widget.filtro.estado;
                if (widget.filtro.estado) {
                  await markersProvider.addMarkers(
                      context, widget.filtro.nombre);

                  setState(() {});
                } else {
                  await markersProvider.removeMarkers(widget.filtro.nombre);
                  setState(() {});
                }
              },
              child: Container(
                height: size.height * 0.1,
                width: size.width * 0.1,
                foregroundDecoration: widget.filtro.estado
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.grey[200],
                        backgroundBlendMode: BlendMode.saturation,
                      ),
                child: Image(
                  image: ResizeImage(MemoryImage(bytes), width: 65, height: 65),
                ),
              ));
        } else {
          return Container();
        }
      },
    );
  }
}
