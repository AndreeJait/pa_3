// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String?,
      paymentMethod: json['paymentMethod'] as String,
      proof: json['proof'] as String,
      quantity:
          (json['quantity'] as List<dynamic>).map((e) => e as int).toList(),
      sentOption: json['sentOption'] as String,
      status: json['status'] as String,
      stock: (json['stock'] as List<dynamic>)
          .map((e) => ProductStock.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      address: json['address'] as String,
      variant:
          (json['variant'] as List<dynamic>).map((e) => e as String).toList(),
    )
      ..createdAt = json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String)
      ..expiredAt = json['expired_at'] == null
          ? null
          : DateTime.parse(json['expired_at'] as String);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'stock': instance.stock,
      'user': instance.user,
      'status': instance.status,
      'proof': instance.proof,
      'quantity': instance.quantity,
      'sentOption': instance.sentOption,
      'created_at': instance.createdAt?.toIso8601String(),
      'expired_at': instance.expiredAt?.toIso8601String(),
      'paymentMethod': instance.paymentMethod,
      'address': instance.address,
      'total': instance.total,
      'variant': instance.variant,
    };
