import 'package:json_annotation/json_annotation.dart';
import 'package:pa_3/model/order.dart';

part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  List<Order> data;

  OrderResponse({required this.data});

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}

@JsonSerializable()
class OrderSingleResponse {
  Order data;

  OrderSingleResponse({required this.data});

  factory OrderSingleResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderSingleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSingleResponseToJson(this);
}
