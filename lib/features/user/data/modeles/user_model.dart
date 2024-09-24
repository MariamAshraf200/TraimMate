import 'dart:convert';

import 'package:check_weather/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.phone});

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone']);
  }

  Map<String,dynamic> tojson(){
    return {
      id:'id',
      name:'name',
      email : 'email',
      phone :'phone'
    };
  }
}
