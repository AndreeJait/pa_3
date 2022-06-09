// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      token: json['token'] as String,
      data: json['data'] == null
          ? null
          : User.fromJson(json['data'] as Map<String, dynamic>),
      refresh: json['refresh'] as String?,
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'token': instance.token,
      'refresh': instance.refresh,
    };
