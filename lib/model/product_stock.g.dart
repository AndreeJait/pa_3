// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductStock _$ProductStockFromJson(Map<String, dynamic> json) => ProductStock(
      outDate: DateTime.parse(json['outDate'] as String),
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      saleDate: DateTime.parse(json['saleDate'] as String),
      stock: json['stock'] as int,
    );

Map<String, dynamic> _$ProductStockToJson(ProductStock instance) =>
    <String, dynamic>{
      'product': instance.product,
      'stock': instance.stock,
      'saleDate': instance.saleDate.toIso8601String(),
      'outDate': instance.outDate.toIso8601String(),
    };
