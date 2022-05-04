import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show BitmapDescriptor;

Future<BitmapDescriptor> getAssetImageMarker(String image) async {
  late BitmapDescriptor iconMarker;
  await getBytesFromAsset(image).then((value) => {
        iconMarker = BitmapDescriptor.fromBytes(value!),
      });
  return iconMarker;
}

Future<Uint8List?> getBytesFromAsset(String path) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: 100);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      ?.buffer
      .asUint8List();
}
