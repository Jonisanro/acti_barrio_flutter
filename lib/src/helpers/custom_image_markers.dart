import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show BitmapDescriptor;

//*Toma una imagen y la convierte en un BitmapDescriptor
Future<BitmapDescriptor> getAssetImageMarker(String image) async {
  late BitmapDescriptor iconMarker;
  await getBytesFromAsset(image).then((value) => {
        iconMarker = BitmapDescriptor.fromBytes(value!),
      });
  return iconMarker;
}

//*Transforma una imagen en una lista de bytes
Future<Uint8List?> getBytesFromAsset(String path) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: 125);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      ?.buffer
      .asUint8List();
}
