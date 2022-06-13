import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:pa_3/model/product.dart';
import 'package:pa_3/model/product_stock.dart';
import 'package:pa_3/model/user.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: "_id")
  String? id;
  List<ProductStock> stock;
  User? user;
  String status;
  String proof;
  List<int> quantity;
  String sentOption;
  String paymentMethod;
  double total;
  List<String> variant;
  Order(
      {this.id,
      required this.paymentMethod,
      required this.proof,
      required this.quantity,
      required this.sentOption,
      required this.status,
      required this.stock,
      required this.total,
      required this.user,
      required this.variant});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
