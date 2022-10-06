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
    required this.fechas,
    required this.contacto,
    required this.usuarioCreador,
    required this.usuarioResponsable,
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.descripcion,
    required this.altura,
    required this.latitud,
    required this.longitud,
    required this.estado,
    required this.tipo,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  Localidad localidad;
  Fechas fechas;
  Contacto contacto;
  UsuarioCreador usuarioCreador;
  UsuarioResponsable usuarioResponsable;
  String id;
  String nombre;
  String direccion;
  String descripcion;
  int altura;
  double latitud;
  double longitud;
  String estado;
  String tipo;
  String createdAt;
  String updatedAt;
  int v;

  factory Evento.fromJson(String str) => Evento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Evento.fromMap(Map<String, dynamic> json) => Evento(
        localidad: Localidad.fromMap(json["localidad"]),
        fechas: Fechas.fromMap(json["fechas"]),
        contacto: Contacto.fromMap(json["Contacto"]),
        usuarioCreador: UsuarioCreador.fromMap(json["UsuarioCreador"]),
        usuarioResponsable:
            UsuarioResponsable.fromMap(json["UsuarioResponsable"]),
        id: json["_id"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        descripcion: json["descripcion"],
        altura: json["altura"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        estado: json["estado"],
        tipo: json["tipo"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "localidad": localidad.toMap(),
        "fechas": fechas.toMap(),
        "Contacto": contacto.toMap(),
        "UsuarioCreador": usuarioCreador.toMap(),
        "UsuarioResponsable": usuarioResponsable.toMap(),
        "_id": id,
        "nombre": nombre,
        "direccion": direccion,
        "descripcion": descripcion,
        "altura": altura,
        "latitud": latitud,
        "longitud": longitud,
        "activo": estado,
        "tipo": tipo,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
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

class Fechas {
  Fechas({
    required this.tipo,
    required this.fechaInicio,
    required this.fechaFin,
    required this.fechas,
  });

  String tipo;
  String fechaInicio;
  String fechaFin;
  List<dynamic> fechas;

  factory Fechas.fromJson(String str) => Fechas.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Fechas.fromMap(Map<String, dynamic> json) => Fechas(
        tipo: json["tipo"],
        fechaInicio: json["fechaInicio"],
        fechaFin: json["fechaFin"],
        fechas: List<dynamic>.from(json["fechas"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "tipo": tipo,
        "fechaInicio": fechaInicio,
        "fechaFin": fechaFin,
        "fechas": List<dynamic>.from(fechas.map((x) => x)),
      };
}

class FechaClass {
  FechaClass({
    required this.lunes,
    required this.martes,
    required this.mircoles,
    required this.jueves,
    required this.viernes,
    required this.sbado,
    required this.domingo,
  });

  Domingo lunes;
  Domingo martes;
  Domingo mircoles;
  Domingo jueves;
  Domingo viernes;
  Domingo sbado;
  Domingo domingo;

  factory FechaClass.fromJson(String str) =>
      FechaClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FechaClass.fromMap(Map<String, dynamic> json) => FechaClass(
        lunes: Domingo.fromMap(json["lunes"]),
        martes: Domingo.fromMap(json["martes"]),
        mircoles: Domingo.fromMap(json["miércoles"]),
        jueves: Domingo.fromMap(json["jueves"]),
        viernes: Domingo.fromMap(json["viernes"]),
        sbado: Domingo.fromMap(json["sábado"]),
        domingo: Domingo.fromMap(json["domingo"]),
      );

  Map<String, dynamic> toMap() => {
        "lunes": lunes.toMap(),
        "martes": martes.toMap(),
        "miércoles": mircoles.toMap(),
        "jueves": jueves.toMap(),
        "viernes": viernes.toMap(),
        "sábado": sbado.toMap(),
        "domingo": domingo.toMap(),
      };
}

class Domingo {
  Domingo({
    required this.inicio,
    required this.fin,
  });

  String inicio;
  String fin;

  factory Domingo.fromJson(String str) => Domingo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Domingo.fromMap(Map<String, dynamic> json) => Domingo(
        inicio: json["inicio"],
        fin: json["fin"],
      );

  Map<String, dynamic> toMap() => {
        "inicio": inicio,
        "fin": fin,
      };
}

class Localidad {
  Localidad({
    required this.barrio,
    required this.nombre,
    required this.latitud,
    required this.longitud,
  });

  Barrio barrio;
  String nombre;
  double latitud;
  double longitud;

  factory Localidad.fromJson(String str) => Localidad.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Localidad.fromMap(Map<String, dynamic> json) => Localidad(
        barrio: Barrio.fromMap(json["barrio"]),
        nombre: json["nombre"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "barrio": barrio.toMap(),
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
  Filtro(
      {required this.id,
      required this.nombre,
      required this.imagen,
      required this.activo,
      required this.descripcion,
      required this.publicId,
      required this.v,
      required this.estado});

  String id;
  String nombre;
  String imagen;
  bool activo;
  String descripcion;
  String publicId;
  int v;
  bool estado;

  factory Filtro.fromJson(String str) => Filtro.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Filtro.fromMap(Map<String, dynamic> json) => Filtro(
        id: json["_id"],
        nombre: json["nombre"],
        imagen: json["imagen"],
        activo: json["activo"],
        descripcion: json["descripcion"],
        publicId: json["public_id"],
        v: json["__v"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
        "imagen": imagen,
        "activo": activo,
        "descripcion": descripcion,
        "public_id": publicId,
        "__v": v,
        "estado": estado,
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
