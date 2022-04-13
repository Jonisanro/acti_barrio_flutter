import 'package:acti_barrio_flutter/src/widgets/custom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';



// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
 MapboxMapController? mapController;
    _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }
    return     Scaffold(
      body: Center(
        child: MapboxMap(
            accessToken: 'sk.eyJ1Ijoiam9uaXNhbnJvIiwiYSI6ImNsMXdnNjhhczFveHEzaXFzc3hkNHZzMDIifQ.-1yksXOQtxtnF5Dk6vTK0g',
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(target: LatLng(-38.953999, -68.056174)),
          ),
      ),

      bottomNavigationBar: const Align(alignment: Alignment.bottomCenter,child: CustomBottonBar()),
     
        );
  }
}
