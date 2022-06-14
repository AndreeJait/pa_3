import 'package:json_annotation/json_annotation.dart';

part 'product_request.g.dart';

@JsonSerializable()
class ProductRequest {
  int limit;
  int skip;
  ProductRequest({this.limit = 20, this.skip = 0});
  factory ProductRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRequestToJson(this);
}

@JsonSerializable()
class ProductStockRequest {
  String product;
  List<int> stock;
  String saleDate;
  String outDate;
  ProductStockRequest(
      {required this.outDate,
      required this.stock,
      required this.product,
      required this.saleDate});
  factory ProductStockRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductStockRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductStockRequestToJson(this);
}

@JsonSerializable()
class ProductStockEditRequest {
  @JsonKey(name: "_id")
  String id;
  String product;
  List<int> stock;
  String saleDate;
  String outDate;
  ProductStockEditRequest(
      {required this.outDate,
      required this.id,
      required this.stock,
      required this.product,
      required this.saleDate});
  factory ProductStockEditRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductStockEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductStockEditRequestToJson(this);
}
