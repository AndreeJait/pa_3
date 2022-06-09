// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      role: json['role'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'password': instance.password,
      'email': instance.email,
      '_id': instance.id,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'role': instance.role,
    };
