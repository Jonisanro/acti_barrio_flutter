// To parse this JSON data, do
//
//     final markersResponse = markersResponseFromMap(jsonString);

import 'dart:convert';

class MarkersResponse {
  MarkersResponse({
    required this.results,
  });

  List<MarkerP> results;

  factory MarkersResponse.fromJson(String str) =>
      MarkersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MarkersResponse.fromMap(Map<String, dynamic> json) => MarkersResponse(
        results:
            List<MarkerP>.from(json["results"].map((x) => MarkerP.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class MarkerP {
  MarkerP({
    required this.id,
    required this.descripcion,
    required this.direccion,
    required this.latitud,
    required this.longitud,
    required this.activo,
    required this.telefono,
    required this.tipo,
  });

  Id id;
  String descripcion;
  String direccion;
  double latitud;
  double longitud;
  bool activo;
  String telefono;
  String tipo;

  factory MarkerP.fromJson(String str) => MarkerP.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MarkerP.fromMap(Map<String, dynamic> json) => MarkerP(
        id: Id.fromMap(json["_id"]),
        descripcion: json["descripcion"],
        direccion: json["direccion"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        activo: json["activo"],
        telefono: json["telefono"] == null ? '' : json["telefono"],
        tipo: json["tipo"] == null ? '' : json["tipo"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id.toMap(),
        "descripcion": descripcion,
        "direccion": direccion,
        "latitud": latitud,
        "longitud": longitud,
        "activo": activo,
        "telefono": telefono == null ? '' : telefono,
        "tipo": tipo == null ? '' : tipo,
      };
}

class Id {
  Id({
    required this.oid,
  });

  String oid;

  factory Id.fromJson(String str) => Id.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Id.fromMap(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"],
      );

  Map<String, dynamic> toMap() => {
        "\u0024oid": oid,
      };
}
