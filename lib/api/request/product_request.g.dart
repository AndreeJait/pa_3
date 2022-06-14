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

ProductStockRequest _$ProductStockRequestFromJson(Map<String, dynamic> json) =>
    ProductStockRequest(
      outDate: json['outDate'] as String,
      stock: (json['stock'] as List<dynamic>).map((e) => e as int).toList(),
      product: json['product'] as String,
      saleDate: json['saleDate'] as String,
    );

Map<String, dynamic> _$ProductStockRequestToJson(
        ProductStockRequest instance) =>
    <String, dynamic>{
      'product': instance.product,
      'stock': instance.stock,
      'saleDate': instance.saleDate,
      'outDate': instance.outDate,
    };

ProductStockEditRequest _$ProductStockEditRequestFromJson(
        Map<String, dynamic> json) =>
    ProductStockEditRequest(
      outDate: json['outDate'] as String,
      id: json['_id'] as String,
      stock: (json['stock'] as List<dynamic>).map((e) => e as int).toList(),
      product: json['product'] as String,
      saleDate: json['saleDate'] as String,
    );

Map<String, dynamic> _$ProductStockEditRequestToJson(
        ProductStockEditRequest instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'product': instance.product,
      'stock': instance.stock,
      'saleDate': instance.saleDate,
      'outDate': instance.outDate,
    };
