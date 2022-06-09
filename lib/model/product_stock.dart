import 'package:json_annotation/json_annotation.dart';
import 'package:pa_3/model/product.dart';

part 'product_stock.g.dart';

@JsonSerializable()
class ProductStock {
  Product product;
  int stock;
  DateTime saleDate;
  DateTime outDate;
  ProductStock(
      {required this.outDate,
      required this.product,
      required this.saleDate,
      required this.stock});

  factory ProductStock.fromJson(Map<String, dynamic> json) =>
      _$ProductStockFromJson(json);

  Map<String, dynamic> toJson() => _$ProductStockToJson(this);
}
