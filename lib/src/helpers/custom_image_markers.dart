import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show BitmapDescriptor;

//*Toma una imagen y la convierte en un BitmapDescriptor
Future<BitmapDescriptor> getAssetImageMarker(
    String image, BuildContext context) async {
  late BitmapDescriptor iconMarker;
  await getBytesFromAsset(context, image).then((value) => {
        iconMarker = BitmapDescriptor.fromBytes(value!),
      });
  return iconMarker;
}

//*Transforma una imagen en una lista de bytes
Future<Uint8List?> getBytesFromAsset(BuildContext context, String path) async {
  final size = MediaQuery.of(context).size;
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetWidth: (size.width * 0.25).toInt(),
    targetHeight: (size.width * 0.25).toInt(),
  );
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      ?.buffer
      .asUint8List();
}
