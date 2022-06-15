// To parse this JSON data, do
//
//     final markersResponse = markersResponseFromMap(jsonString);

import 'dart:convert';

class FiltrosResponse {
  FiltrosResponse({
    required this.results,
  });

  List<Filtro> results;

  factory FiltrosResponse.fromJson(String str) =>
      FiltrosResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FiltrosResponse.fromMap(Map<String, dynamic> json) => FiltrosResponse(
        results:
            List<Filtro>.from(json["results"].map((x) => Filtro.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Filtro {
  Filtro({
    required this.id,
    required this.nombre,
    required this.imagen,
    required this.activo,
    required this.v,
  });

  String id;
  String nombre;
  String imagen;
  bool activo;
  int v;

  factory Filtro.fromJson(String str) => Filtro.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Filtro.fromMap(Map<String, dynamic> json) => Filtro(
        id: json["_id"],
        nombre: json["nombre"],
        imagen: json["imagen"],
        activo: json["activo"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
        "imagen": imagen,
        "activo": activo,
        "__v": v,
      };
}
