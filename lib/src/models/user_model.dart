import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String nombre;
  String apellido;
  String tipoDocumento;
  String nDocumento;
  String correo;
  String celular;
  String fechaNacimiento;
  String fotoUrl;

  UserModel(
      {this.nombre,
      this.apellido,
      this.tipoDocumento,
      this.nDocumento,
      this.correo,
      this.celular,
      this.fechaNacimiento,
      this.fotoUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        nombre:         json["nombre"],
        apellido:       json["apellido"],
        tipoDocumento:  json["tipo_documento"],
        nDocumento:     json["n_documento"],
        correo:         json["correo"],
        celular:        json["celular"],
        fechaNacimiento:json["fecha_nacimiento"],
        fotoUrl:        json["foto_url"],
      );

  Map<String, dynamic> toJson() => {
        "nombre":           nombre,
        "apellido":         apellido,
        "tipo_documento":   tipoDocumento,
        "n_documento":      nDocumento,
        "correo":           correo,
        "celular":          celular,
        "fecha_nacimiento": fechaNacimiento,
        "foto_url":         fotoUrl,
      };
}
