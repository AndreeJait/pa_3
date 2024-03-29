import 'package:json_annotation/json_annotation.dart';
import 'package:pa_3/model/product.dart';
import 'package:pa_3/model/product_stock.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductActiveResponse {
  List<ProductStock> data;

  ProductActiveResponse({required this.data});

  factory ProductActiveResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductActiveResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductActiveResponseToJson(this);
}

@JsonSerializable()
class ProductResponse {
  List<Product> data;

  ProductResponse({required this.data});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
class ProductSingleResponse {
  Product data;

  ProductSingleResponse({required this.data});

  factory ProductSingleResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductSingleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSingleResponseToJson(this);
}

@JsonSerializable()
class ProductActiveSingleResponse {
  ProductStock data;

  ProductActiveSingleResponse({required this.data});

  factory ProductActiveSingleResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductActiveSingleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductActiveSingleResponseToJson(this);
}
