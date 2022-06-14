// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

OrderSingleResponse _$OrderSingleResponseFromJson(Map<String, dynamic> json) =>
    OrderSingleResponse(
      data: Order.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderSingleResponseToJson(
        OrderSingleResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
