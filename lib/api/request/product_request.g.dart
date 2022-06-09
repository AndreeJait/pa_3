// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductRequest _$ProductRequestFromJson(Map<String, dynamic> json) =>
    ProductRequest(
      limit: json['limit'] as int? ?? 20,
      skip: json['skip'] as int? ?? 0,
    );

Map<String, dynamic> _$ProductRequestToJson(ProductRequest instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'skip': instance.skip,
    };
