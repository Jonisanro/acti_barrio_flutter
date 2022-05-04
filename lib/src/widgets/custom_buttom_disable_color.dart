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
  bool disable = true;

  @override
  Widget build(BuildContext context) {
    final markersProvider =
        Provider.of<MarkersProviders>(context, listen: false);
    return InkWell(
      onTap: () async {
        disable = !disable;

        if (disable) {
          markersProvider.addMarkers(widget.nombreFiltro);
        } else {
          if (!disable) {
            markersProvider.removeMarkers(widget.nombreFiltro);
          }
        }

        setState(() {});
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
        ),
        foregroundDecoration: disable
            ? null
            : BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.grey[200],
                backgroundBlendMode: BlendMode.saturation,
              ),
        child: Image(
          image: AssetImage(widget.assetImage),
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
