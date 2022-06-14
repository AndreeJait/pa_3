// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) => OrderRequest(
      limit: json['limit'] as int? ?? 20,
      skip: json['skip'] as int? ?? 0,
    );

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'skip': instance.skip,
    };

OrderNewRequest _$OrderNewRequestFromJson(Map<String, dynamic> json) =>
    OrderNewRequest(
      paymentMethod: json['paymentMethod'] as String,
      quantity:
          (json['quantity'] as List<dynamic>).map((e) => e as int).toList(),
      sentOption: json['sentOption'] as String,
      status: json['status'] as String,
      stock: json['stock'] as String,
      total: json['total'] as int,
      user: json['user'] as String,
      variant:
          (json['variant'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OrderNewRequestToJson(OrderNewRequest instance) =>
    <String, dynamic>{
      'stock': instance.stock,
      'variant': instance.variant,
      'quantity': instance.quantity,
      'sentOption': instance.sentOption,
      'paymentMethod': instance.paymentMethod,
      'total': instance.total,
      'user': instance.user,
      'status': instance.status,
    };

OrderStatusRequest _$OrderStatusRequestFromJson(Map<String, dynamic> json) =>
    OrderStatusRequest(
      id: json['_id'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$OrderStatusRequestToJson(OrderStatusRequest instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
    };
