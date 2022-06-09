// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductActiveResponse _$ProductActiveResponseFromJson(
        Map<String, dynamic> json) =>
    ProductActiveResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => ProductStock.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductActiveResponseToJson(
        ProductActiveResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
