// To parse this JSON data, do
//
//     final markersResponse = markersResponseFromMap(jsonString);

import 'dart:convert';

class MarkersResponse {
  MarkersResponse({
    required this.results,
  });

  List<Evento> results;

  factory MarkersResponse.fromJson(String str) =>
      MarkersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MarkersResponse.fromMap(Map<String, dynamic> json) => MarkersResponse(
        results:
            List<Evento>.from(json["results"].map((x) => Evento.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Evento {
  Evento({
    required this.contacto,
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.descripcion,
    required this.latitud,
    required this.longitud,
    required this.activo,
    required this.tipo,
    required this.urlIcono,
    required this.localidad,
    required this.barrio,
    required this.fechaInicio,
    required this.fechaFin,
    required this.favorite,
    required this.v,
  });

  Contacto contacto;
  String id;
  String nombre;
  String direccion;
  String descripcion;
  double latitud;
  double longitud;
  bool activo;
  String tipo;
  String urlIcono;
  String localidad;
  String barrio;
  String fechaInicio;
  String fechaFin;
  bool favorite;
  int v;

  factory Evento.fromJson(String str) => Evento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Evento.fromMap(Map<String, dynamic> json) => Evento(
        contacto: Contacto.fromMap(json["Contacto"]),
        id: json["_id"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        descripcion: json["descripcion"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        activo: json["activo"],
        tipo: json["tipo"],
        urlIcono: json["urlIcono"],
        localidad: json["localidad"],
        barrio: json["barrio"],
        fechaInicio: json["fecha_inicio"],
        fechaFin: json["fecha_fin"],
        favorite: false,
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "Contacto": contacto.toMap(),
        "_id": id,
        "nombre": nombre,
        "direccion": direccion,
        "descripcion": descripcion,
        "latitud": latitud,
        "longitud": longitud,
        "activo": activo,
        "tipo": tipo,
        "urlIcono": urlIcono,
        "localidad": localidad,
        "barrio": barrio,
        "fecha_inicio": fechaInicio,
        "fecha_fin": fechaFin,
        "favorite": false,
        "__v": v,
      };
}

class Contacto {
  Contacto({
    required this.nombreReferente,
    required this.telefono,
    required this.email,
  });

  String nombreReferente;
  String telefono;
  String email;

  factory Contacto.fromJson(String str) => Contacto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Contacto.fromMap(Map<String, dynamic> json) => Contacto(
        nombreReferente: json["nombreReferente"],
        telefono: json["telefono"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "nombreReferente": nombreReferente,
        "telefono": telefono,
        "email": email,
      };
}
