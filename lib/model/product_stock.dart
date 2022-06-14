import 'package:json_annotation/json_annotation.dart';
import 'package:pa_3/model/product.dart';

part 'product_stock.g.dart';

@JsonSerializable()
class ProductStock {
  @JsonKey(name: "_id")
  String? id;
  Product product;
  List<int> stock;
  DateTime saleDate;
  DateTime outDate;
  ProductStock(
      {required this.outDate,
      required this.product,
      required this.saleDate,
      required this.stock,
      this.id});

  factory ProductStock.fromJson(Map<String, dynamic> json) =>
      _$ProductStockFromJson(json);

  Map<String, dynamic> toJson() => _$ProductStockToJson(this);
}
