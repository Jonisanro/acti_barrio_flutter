import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/markers_provider.dart';

class CustomButtonColor extends StatefulWidget {
  final String assetImage;
  final String nombreFiltro;

  const CustomButtonColor(
      {Key? key, required this.assetImage, required this.nombreFiltro})
      : super(key: key);

  @override
  State<CustomButtonColor> createState() => _CustomButtonColorState();
}

class _CustomButtonColorState extends State<CustomButtonColor> {
  @override
  Widget build(BuildContext context) {
    final markersProvider =
        Provider.of<MarkersProviders>(context, listen: false);
    dynamic disable = markersProvider.filtrosEstado[widget.nombreFiltro];

    return InkWell(
      onTap: () async {
        disable = !disable;
        markersProvider.filtrosEstado
            .update(widget.nombreFiltro, (value) => disable);

        if (disable) {
          await markersProvider.addMarkers(widget.nombreFiltro);

          setState(() {});
        } else {
          if (!disable) {
            await markersProvider.removeMarkers(widget.nombreFiltro);
            setState(() {});
          }
        }
      },
      child: Container(
        foregroundDecoration: disable
            ? null
            : BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.grey[200],
                backgroundBlendMode: BlendMode.saturation,
              ),
        child: Image(
          image: AssetImage(widget.assetImage),
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
