import 'package:json_annotation/json_annotation.dart';

part 'order_request.g.dart';

@JsonSerializable()
class OrderRequest {
  int limit;
  int skip;
  OrderRequest({this.limit = 20, this.skip = 0});
  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);
}

@JsonSerializable()
class OrderNewRequest {
  String stock;
  List<String> variant;
  List<int> quantity;
  String sentOption;
  String paymentMethod;
  int total;
  String user;
  String status;
  OrderNewRequest(
      {required this.paymentMethod,
      required this.quantity,
      required this.sentOption,
      required this.status,
      required this.stock,
      required this.total,
      required this.user,
      required this.variant});
  factory OrderNewRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderNewRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderNewRequestToJson(this);
}

@JsonSerializable()
class OrderStatusRequest {
  @JsonKey(name: "_id")
  String id;
  String status;
  OrderStatusRequest({required this.id, required this.status});
  factory OrderStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusRequestToJson(this);
}
