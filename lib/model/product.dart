import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: "_id")
  String? id;
  String name;
  int productDurable;
  int weight;
  int temperatureStorage;
  List<String> variant;
  List<String> variantImages;
  List<double> priceVariant;
  List<String> otherImage;
  bool isDelete;
  Product(
      {this.id,
      required this.name,
      required this.weight,
      required this.isDelete,
      required this.otherImage,
      required this.priceVariant,
      required this.productDurable,
      required this.temperatureStorage,
      required this.variant,
      required this.variantImages});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
