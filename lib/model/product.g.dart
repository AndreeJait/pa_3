// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] as String?,
      name: json['name'] as String,
      weight: json['weight'] as int,
      isDelete: json['isDelete'] as bool,
      otherImage: (json['otherImage'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      priceVariant: (json['priceVariant'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      productDurable: json['productDurable'] as int,
      temperatureStorage: json['temperatureStorage'] as int,
      variant:
          (json['variant'] as List<dynamic>).map((e) => e as String).toList(),
      variantIndex:
          (json['variantIndex'] as List<dynamic>).map((e) => e as int).toList(),
      variantImages: (json['variantImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'productDurable': instance.productDurable,
      'weight': instance.weight,
      'temperatureStorage': instance.temperatureStorage,
      'variant': instance.variant,
      'variantImages': instance.variantImages,
      'priceVariant': instance.priceVariant,
      'variantIndex': instance.variantIndex,
      'otherImage': instance.otherImage,
      'isDelete': instance.isDelete,
    };
