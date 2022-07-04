// To parse this JSON data, do
//
//     final markersResponse = markersResponseFromMap(jsonString);

import 'dart:convert';

class MarkersResponse {
  MarkersResponse({
    required this.eventos,
    required this.localidades,
    required this.filtros,
  });

  List<Evento> eventos;
  List<Localidades> localidades;
  List<Filtro> filtros;

  factory MarkersResponse.fromJson(String str) =>
      MarkersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MarkersResponse.fromMap(Map<String, dynamic> json) => MarkersResponse(
        eventos:
            List<Evento>.from(json["eventos"].map((x) => Evento.fromMap(x))),
        localidades: List<Localidades>.from(
            json["localidades"].map((x) => Localidades.fromMap(x))),
        filtros:
            List<Filtro>.from(json["filtros"].map((x) => Filtro.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "eventos": List<dynamic>.from(eventos.map((x) => x.toMap())),
        "localidades": List<dynamic>.from(localidades.map((x) => x.toMap())),
        "filtros": List<dynamic>.from(filtros.map((x) => x.toMap())),
      };
}

class Evento {
  Evento({
    required this.localidad,
    required this.contacto,
    required this.usuarioCreador,
    required this.usuarioResponsable,
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.descripcion,
    required this.latitud,
    required this.longitud,
    required this.activo,
    required this.tipo,
    required this.fechaInicio,
    required this.fechaFin,
    required this.v,
  });

  Localidad localidad;
  Contacto contacto;
  UsuarioCreador usuarioCreador;
  UsuarioResponsable usuarioResponsable;
  String id;
  String nombre;
  String direccion;
  String descripcion;
  double latitud;
  double longitud;
  bool activo;
  String tipo;
  String fechaInicio;
  String fechaFin;
  int v;

  factory Evento.fromJson(String str) => Evento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Evento.fromMap(Map<String, dynamic> json) => Evento(
        localidad: Localidad.fromMap(json["localidad"]),
        contacto: Contacto.fromMap(json["Contacto"]),
        usuarioCreador: UsuarioCreador.fromMap(json["UsuarioCreador"]),
        usuarioResponsable:
            UsuarioResponsable.fromMap(json["UsuarioResponsable"]),
        id: json["_id"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        descripcion: json["descripcion"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        activo: json["activo"],
        tipo: json["tipo"],
        fechaInicio: json["fecha_inicio"],
        fechaFin: json["fecha_fin"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "localidad": localidad.toMap(),
        "Contacto": contacto.toMap(),
        "UsuarioCreador": usuarioCreador.toMap(),
        "UsuarioResponsable": usuarioResponsable.toMap(),
        "_id": id,
        "nombre": nombre,
        "direccion": direccion,
        "descripcion": descripcion,
        "latitud": latitud,
        "longitud": longitud,
        "activo": activo,
        "tipo": tipo,
        "fecha_inicio": fechaInicio,
        "fecha_fin": fechaFin,
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

class Localidad {
  Localidad({
    required this.barrio,
    required this.nombre,
    required this.latitud,
    required this.longitud,
  });

  Barrio? barrio;
  String nombre;
  double latitud;
  double longitud;

  factory Localidad.fromJson(String str) => Localidad.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Localidad.fromMap(Map<String, dynamic> json) => Localidad(
        barrio: json["barrio"] == null ? null : Barrio.fromMap(json["barrio"]),
        nombre: json["nombre"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "barrio": barrio == null ? null : barrio!.toMap(),
        "nombre": nombre,
        "latitud": latitud,
        "longitud": longitud,
      };
}

class Barrio {
  Barrio({
    required this.nombre,
    required this.latitud,
    required this.longitud,
  });

  String nombre;
  double latitud;
  double longitud;

  factory Barrio.fromJson(String str) => Barrio.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Barrio.fromMap(Map<String, dynamic> json) => Barrio(
        nombre: json["nombre"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "latitud": latitud,
        "longitud": longitud,
      };
}

class UsuarioCreador {
  UsuarioCreador({
    required this.nombre,
    required this.id,
    required this.email,
  });

  String nombre;
  String id;
  String email;

  factory UsuarioCreador.fromJson(String str) =>
      UsuarioCreador.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsuarioCreador.fromMap(Map<String, dynamic> json) => UsuarioCreador(
        nombre: json["nombre"],
        id: json["id"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "id": id,
        "email": email,
      };
}

class UsuarioResponsable {
  UsuarioResponsable({
    required this.nombre,
    required this.email,
    required this.telefono,
  });

  String nombre;
  String email;
  String telefono;

  factory UsuarioResponsable.fromJson(String str) =>
      UsuarioResponsable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsuarioResponsable.fromMap(Map<String, dynamic> json) =>
      UsuarioResponsable(
        nombre: json["nombre"],
        email: json["email"],
        telefono: json["telefono"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "email": email,
        "telefono": telefono,
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

class Localidades {
  Localidades({
    required this.nombre,
    required this.latitud,
    required this.longitud,
    required this.barriosLista,
  });

  String nombre;
  double latitud;
  double longitud;
  List<Barrio> barriosLista;

  factory Localidades.fromJson(String str) =>
      Localidades.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Localidades.fromMap(Map<String, dynamic> json) => Localidades(
        nombre: json["nombre"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        barriosLista: List<Barrio>.from(
            json["barriosLista"].map((x) => Barrio.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "latitud": latitud,
        "longitud": longitud,
        "barriosLista": List<dynamic>.from(barriosLista.map((x) => x.toMap())),
      };
}
